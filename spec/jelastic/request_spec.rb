require 'spec_helper'

describe Jelastic::Request do
  it 'builds uri path from array of paths' do
    client = instance_double('Client', session: 'secret', authenticated?: true)
    request = Jelastic::Request.new(client, ['foo/', '/bar', 'baz'])

    expect(request.path).to eq('foo/bar/baz')
  end

  context 'client not authenticated' do
    it 'adds login and password to params' do
      client = instance_double(
        'Client',
        session: 'secret', authenticated?: false, login: 'foo', password: 'bar'
      )

      request = Jelastic::Request.new(client, [], { data: 'osom' })

      expected_params = {
        data: 'osom',
        login: 'foo',
        password: 'bar'
      }
      expect(request.params).to eq(expected_params)
    end
  end

  context 'client authenticated' do
    it 'adds session to params' do
      client = instance_double('Client', session: 'secret', authenticated?: true)

      request = Jelastic::Request.new(client, [], { data: 'osom' })

      expected_params = {
        data: 'osom',
        session: 'secret'
      }
      expect(request.params).to eq(expected_params)
    end
  end

  context 'server returns response with result param != 0' do
    it 'raises an exception' do
      client = instance_double('Client', session: 'secret', authenticated?: true)
      response = double('response', body: '{ "result":1, "error":"Fatal error" }')
      allow_any_instance_of(Net::HTTP).to receive(:request).and_return(response)

      expect{ Jelastic::Request.new(client, [], {}).send }.to raise_error(Jelastic::RequestError, 'Fatal error')
    end
  end
end
