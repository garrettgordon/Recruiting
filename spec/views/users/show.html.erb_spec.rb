<!DOCTYPE html>
<html>
    <head>
      <title>Bootflat Template</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <!-- Bootstrap -->
      <link href="bootstrap/bootstrap.min.css" rel="stylesheet" media="screen">
      <link href="css/font-awesome.min.css" rel="stylesheet" media="screen">
      <link href="css/bootflat.css" rel="stylesheet" media="screen">
      <link href="css/bootflat-extensions.css" rel="stylesheet" media="screen">
      <link href="css/bootflat-square.css" rel="stylesheet" media="screen">

      <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
      <!--[if lt IE 9]>
        <script src="js/html5shiv.js"></script>
        <script src="js/respond.min.js"></script>
      <![endif]-->
    </head>
    <body>
      <h1>Hello, world!</h1>

      <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
      <script src="//code.jquery.com/jquery.js"></script>
      <!-- Include all compiled plugins (below), or include individual files as needed -->
      <script src="js/bootstrap.min.js"></script>
    </body>
</html>

require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :username => "Username",
      :email => "Email",
      :password => "Password"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Username/)
    rendered.should match(/Email/)
    rendered.should match(/Password/)
  end
end
