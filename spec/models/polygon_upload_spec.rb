require 'spec_helper'

describe PolygonUpload do
  describe ".create_with_file" do
    context "for an area and file" do
      before(:all) do
        @area_of_interest = FactoryGirl.create(:area_of_interest)
        @file_txt = 'testing'

        Dir.mkdir('tmp/') unless File.exists?('tmp/')

        test_file = File.open("tmp/testingTest.txt", 'w')
        test_file.write(@file_txt)
        test_file.close()
        test_file = File.open("tmp/testingTest.txt", 'r')

        upload_file = ActionDispatch::Http::UploadedFile.new(
          filename: "testingTest.txt",
          tempfile: test_file
        )

        @polygon_upload = PolygonUpload.create_with_file(area_of_interest_id: @area_of_interest.id, file: upload_file)
      end

      it "should have created a new PolygonUpload successfully" do
        @polygon_upload.id.should_not be_nil
      end

      it "should have set the AOI correctly" do
        @polygon_upload.area_of_interest.should eq(@area_of_interest)
      end

      it "should create a new PolygonUpload with the file written to disk" do
        File.open(@polygon_upload.filename, 'r').read.should eq(@file_txt)
      end

      describe " then #cleanup" do
        before(:all) do
          @file_to_delete = @polygon_upload.filename
          @polygon_upload.cleanup
        end
        it "should delete the file" do
          expect { File.open(@file_to_delete, 'r') }.to raise_error
        end
      end
    end
  end
end
