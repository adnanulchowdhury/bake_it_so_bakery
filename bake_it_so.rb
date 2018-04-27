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

get "/" do
    erb :index
end

post "/" do
    from = Email.new(email: 'bakeitso@gmail.com')
    to = Email.new(email: params[:email])
    subject = "Bake It So Newsletter"
    content = Content.new(type: 'text/html', value: 
    '<h2>Bake It So!</h2>
     <h6>Cakes</h6>
        <ul>
            <li>Sci-Fi themed cake.</li>
            <li>Strawberry Cream cake.</li>
            <li>Ultimate Chocolate cake.</li>
            <li>Red Velvet cake.</li>
            <li>Mango Blast cake.</li>
            <li>Blueberry layered cake.</li>
        </ul>
     <h6>Cake Pops</h6>
        <ul>
            <li>Strawberry Cake Pop.</li>
            <li>Red Velvet Cake Pop.</li>
            <li>Blueberry Cake Pop.</li>
            <li>Rainbow Cake Pop.</li>
            <li>Golden Snitch Pop.</li>
            <li>Watermelon Pop.</li>
        </ul>
     <h6>Cookies</h6>
        <ul>
            <li>Peanut Butter.</li>
            <li>Oatmeal Raisin.</li>
            <li>Cheescake Cookie.</li>
            <li>Chocolate Chip.</li>
            <li>White Chocolate Chip.</li>
            <li>Red Velvet.</li>
        </ul>
    ')
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    # puts response.status_code
    # puts response.body
    # puts response.parsed_body
    # puts response.headers
    redirect "/"
end

get "/thank_you" do
    "Thank You"
end