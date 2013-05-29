require 'spec_helper'

describe Result do
  describe '.update_value_timestamp' do
    context 'on result with no value' do
      before(:each) do
        @updated_time = 5.days.ago
        @result = FactoryGirl.create(:result, value: nil, value_updated_at: @updated_time)
        @result.update_value_timestamp
      end

      it 'does not update the value cache timestamp' do
        @result.value_updated_at.should eq(@updated_time)
      end
    end

    context 'on result where value has not changed' do
      before(:each) do
        @updated_time = 5.days.ago
        @result = FactoryGirl.create(:result, value: "10", value_updated_at: @updated_time)
        @result.statistic_id = 100
        @result.update_value_timestamp
      end

      it 'does not update the value cache timestamp' do
        @result.value_updated_at.should eq(@updated_time)
      end
    end

    context 'on result where value has changed' do
      before(:each) do
        @result = FactoryGirl.create(:result, value: "10", value_updated_at: 5.days.ago)
        @result.value = "100"
        @result.update_value_timestamp
      end

      it 'updates the value cache timestamp' do
        @result.value_updated_at.should be > Date.today
      end
    end
  end

  describe '.has_more_recent_value_than?' do
    context 'a result with no value' do
      before(:each) do
        @result = FactoryGirl.create(:result, value: nil)
      end
      it 'returns false' do
        @result.has_more_recent_value_than?(Time.now).should eql(false)
      end
    end

    context 'a result with a value' do
      before(:each) do
        @result = FactoryGirl.create(:result, value: 'hat')
      end

      context 'given a more recent timestamp' do
        it 'returns false' do
          @result.has_more_recent_value_than?(5.days.from_now).should eql(false)
        end
      end

      context 'given a less recent timestamp' do
        it 'returns true' do
          @result.has_more_recent_value_than?(5.days.ago).should eql(true)
        end
      end
    end
  end

  describe '#fetch' do
    context 'an error is thrown by statistic calculation' do
      before(:all) do
        @result = FactoryGirl.create(:result)
        @result.statistic.project_layer.class.stub(:fetch_result) do
          raise "Some error"
        end
      end

      it 'catches the error' do
        expect{@result.fetch}.to_not raise_error
      end

      context "and then" do
        it 'writes the error message to .error_message ' do
          @result.error_message.should eq('Some error')
        end

        it 'writes the error stack to .error_stack ' do
          @result.error_stack.should match(/app\/models\/result.rb/)
        end
      end
    end
    
    context "result exists with an error message and stack" do
      before(:all) do
        @result = FactoryGirl.create(:result, error_message: 'Boots stuck', error_stack: 'app/models/cowboy.rb:15')
      end

      context "results are successfully fetched" do
        before(:all) do
          @result.statistic.project_layer.class.stub(:fetch_result) do
            '5'
          end
          @result.fetch
        end
        
        it 'unsets the error messages' do
          @result.error_message.should be_nil()
        end

        it 'unsets the error messages' do
          @result.error_stack.should be_nil()
        end
      end
    end
  end
end
