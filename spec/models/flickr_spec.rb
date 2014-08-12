require 'spec_helper'

describe Flickr do
  it 'parses Flickr API json result correctly' do
    allow(Flickr).to receive(:call_api) { 
      <<-eos
      {
        "photos": {
          "page": 2, "pages": 80, "perpage": 100, "total": "8000",
          "photo": [
            {
              "id": "1", "owner": "2384@N06", "secret": "sec1", "server": "5593", "farm": 6,
              "title": "I am at Niagara Falls", "ispublic": 1, "isfriend": 0, "isfamily": 0
            },
            { "id": "2", "owner": "238@N06", "secret": "sec2", "server": "5560", "farm": 3,
              "title": "Oscar and Irene visited Niagara", "ispublic": 1, "isfriend": 1, "isfamily": 0
            }
          ]
        }
      }
      eos
    }

    result = Flickr.search(text: 'Niagara')

    result[:page].should == 2
    result[:pages].should == 80
    
    photo0 = result[:photos][0]
    photo0.id.should == "1"
    photo0.server.should == "5593"

    photo1 = result[:photos][1]
    photo1.owner.should == "238@N06"
    photo1.farm.should == 3
  end
end