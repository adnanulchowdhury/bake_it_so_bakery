require "sinatra"
require "sendgrid-ruby"

include SendGrid

get "/" do
    erb :index
end

get "/cakes" do
    erb :cakes
end

get "/cake_pops" do
    erb :cake_pops
end

get "/cookies" do
    erb :cookies
end

get "/contact_form" do
    erb :contact_form
end

post "/" do
    from = Email.new(email: 'bakeitso@gmail.com')
    to = Email.new(email: params[:email])
    subject = "Bake It So Newsletter"
    content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    # puts response.status_code
    # puts response.body
    # puts response.parsed_body
    # puts response.headers
    redirect "/contact_form"
end

get "/thank_you" do
    "Thank You"
end