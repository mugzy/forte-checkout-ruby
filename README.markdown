This sample code will demonstrate how to create a simple Pay Now button for Checkout using Ruby 4.1.

After testing is complete. 
Change the Secure Transaction Key and API Login ID to their production values.
Change this line <script type="text/javascript" src="https://sandbox.forte.net/checkout/v1/js"> to point to the production enviroment. <script type="text/javascript" src="https://checkout.forte.net/v1/js">

### Rails Configuration

  1. Install [Foreman](https://github.com/ddollar/foreman).
    * if you're on a Mac you can [Download Foreman for Mac](http://assets.foreman.io/foreman/foreman.pkg`) or
    * if you using other Operating System, run `gem install foreman` to install
      foreman.

  2. create a `.env` file in the root of your Rails Project containing the
     following:

        FORTE_API_LOGIN_ID=<Your Generated API Login ID>
        FORTE_SECURE_TRANSACTION_KEY=<Your Generated Secure Transaction Key>

  3. Install all the required gems to run the application via `bundle install`.
  4. Run the application via `foreman start` then visit <http://localhost:5000/>
