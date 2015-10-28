require 'weibo_2'

WeiboOAuth2::Config.api_key = 'abc'
WeiboOAuth2::Config.api_secret = 'def'
WeiboOAuth2::Config.redirect_uri = 'https://example.com/callback'

describe WeiboOAuth2::Client do
  it 'should assign id and secret from config' do
    expect(subject.id).to eq 'abc'
    expect(subject.secret).to eq 'def'
  end

  it 'should assign site from default' do
    expect(subject.site).to eq 'https://api.weibo.com/2/'
  end

  it 'should get authorize_url' do
    authorize_url = 'https://api.weibo.com/oauth2/authorize?client_id=abc&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&response_type=code'
    expect(subject.authorize_url).to eq authorize_url
  end

  it 'should leave Faraday::Connection#ssl unset' do
    expect(subject.connection.ssl).to be_empty
  end

  it "defaults raise_errors to true" do
    expect(subject.options[:raise_errors]).to be_truthy
  end

  it "allows true/false for raise_errors option" do
    client = OAuth2::Client.new('abc', 'def', :site => 'https://api.example.com', :raise_errors => false)
    expect(client.options[:raise_errors]).to be_falsey
    client = OAuth2::Client.new('abc', 'def', :site => 'https://api.example.com', :raise_errors => true)
    expect(client.options[:raise_errors]).to be_truthy
  end

  it "allows get/post for access_token_method option" do
    client = OAuth2::Client.new('abc', 'def', :site => 'https://api.example.com', :access_token_method => :get)
    expect(client.options[:access_token_method]).to eq :get
    client = OAuth2::Client.new('abc', 'def', :site => 'https://api.example.com', :access_token_method => :post)
    expect(client.options[:access_token_method]).to eq :post
  end
end
