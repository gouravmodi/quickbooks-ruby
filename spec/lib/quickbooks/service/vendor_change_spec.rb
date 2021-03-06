describe "Quickbooks::Service::VendorChange" do
  before(:all) do
    construct_service :vendor_change
  end

  it "can query for vendors" do
    xml = fixture("vendor_changes.xml")
    model = Quickbooks::Model::VendorChange

    stub_request(:get, @service.url_for_query, ["200", "OK"], xml)
    vendors = @service.query
    vendors.entries.count.should == 1

    first_vendor = vendors.entries.first
    first_vendor.status.should == 'Deleted'
    first_vendor.id.should == 39

    first_vendor.meta_data.should_not be_nil
    first_vendor.meta_data.last_updated_time.should == DateTime.parse("2014-12-08T19:36:24-08:00")
  end

end
