require "spec_helper"

if defined?(Rails)

  class ApplicationController < ActionController::Base

    after_filter :add_gosquared_script, :if => :html_response?

    def add_gosquared_script
      response.body = response.body.gsub(CLOSING_HEAD_TAG, "<script type='text/javascript' async='true'>
        var trackingCode = function(){
          !function(g,s,q,r,d){r=g[r]=g[r]||function(){(r.q=r.q||[]).push(
            arguments)};d=s.createElement(q);q=s.getElementsByTagName(q)[0];
      d.src='//d1l6p2sc9645hc.cloudfront.net/tracker.js';q.parentNode.
      insertBefore(d,q)}(window,document,'script','_gs');
      _gs('GSN-589158-M'); _gs('set', 'trackLocal', true);
      _gs('event', '#{request.headers["PATH_INFO"]}', {
        extra: 'event',
        details: true
        });
      };

      var loadTracker;
      loadTracker=function(){
        if(!window._gs) {
          trackingCode();
          } else {
            delete _gs;
            trackingCode();
          }
          };
          $(document).on('page:load', loadTracker)
          $(document).on('turbolinks:load', loadTracker);
          </script>" + "\n </body>"
          )
    end

    def html_response?
      response.content_type == "text/html"
    end
  end

  describe ApplicationController, :type => :controller do
    controller do
      def index
        render :html => true
      end

      def new
        render :json => true
      end
    end

    it "adds the GoSquared tracking code if response HTML" do
     expect(controller).to receive(:add_gosquared_script)
     get :index
   end

   it "does not add the GoSquared tracking code if response not HTML" do
     expect(controller).not_to receive(:add_gosquared_script)
     get :new
   end

 end
end
