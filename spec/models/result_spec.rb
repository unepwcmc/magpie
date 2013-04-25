require 'spec_helper'

describe Result do
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
