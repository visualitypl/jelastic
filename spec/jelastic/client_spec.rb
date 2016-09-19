require 'spec_helper'

describe Jelastic::Client do
  it 'sets instance variables' do
    client = Jelastic::Client.new do |config|
      config.login = 'foo'
      config.password = 'bar'
      config.api_url = 'https://app.jelastic.dogado.eu/1.0/'
    end

    expect(client.login).to eq('foo')
    expect(client.password).to eq('bar')
    expect(client.api_url).to eq('https://app.jelastic.dogado.eu/1.0/')
  end

  describe '#authenticate' do
    context 'authenticated' do
      it 'signs in and creates a User instance' do
        client = Jelastic::Client.new

        allow(client).to receive(:signin).and_return({
          'uid' => 'asd',
          'email' => 'foo',
          'session' => 'secret',
          'status' => 'ok'
        })

        client.authenticate

        expect(client.authenticated?).to eq(true)
        expect(client.session).to eq('secret')
      end
    end
  end

  describe '#logout' do
    context 'authenticated' do
      it 'sets nil to user and returns null' do
        client = Jelastic::Client.new

        allow(client).to receive(:signin).and_return({
          'uid' => 'asd',
          'email' => 'foo',
          'session' => 'secret',
          'status' => 'ok'
        })
        allow(client).to receive(:signout).and_return(true)

        client.authenticate

        expect(client.logout).to eq(nil)
        expect(client.authenticated?).to eq(false)
      end
    end
    context 'not authenticated' do
      it 'returns null' do
        client = Jelastic::Client.new
        expect(client.logout).to eq(nil)
      end
    end
  end
end
