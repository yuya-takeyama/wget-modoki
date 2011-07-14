require 'spec_helper'

module Wget
  describe Option do
    subject do
      opt = Option.new
      opt.argv = argv
      opt
    end
    let(:url) { "http://example.com" }
    let(:user) { "foo" }
    let(:password) { "bar" }
    let(:user_agent) { "Some User-Agent" }

    share_examples_for 'has URL' do
      it { should have_url }
      its(:url) { should == url }
    end

    context "has empty argument" do
      let(:argv) { [] }

      it { should_not have_url }
    end

    context "has URL as argument" do
      let(:argv) { [url] }
      it_behaves_like 'has URL'
    end

    context "has URL and User-Agent as argument" do
      let(:argv) { ["--user-agent=#{user_agent}", url] }

      it { should have_user_agent }
      its(:user_agent) { should == user_agent }
      it_behaves_like 'has URL'
    end

    context "has URL and user and password as argument" do
      let(:argv) { ["--user=#{user}", "--pass=#{password}", url] }

      it { should have_user }
      it { should have_password }
      its(:user) { should == user }
      its(:password) { should == password }
      it_behaves_like 'has URL'
    end
  end

  describe "#filename" do
    subject do
      opt = Option.new
      opt.argv = argv
      opt.filename
    end
    let(:argv) { [url] }

    context 'url = "http://example.com/"' do
      let(:url) { "http://example.com/" }
      it { should == 'index.html' }
    end

    context 'url = "http://example.com/foo.html"' do
      let(:url) { "http://example.com/foo.html" }
      it { should == 'foo.html' }
    end

    context 'has "-O" "foo/bar.html" as arguments' do
      let(:argv) { [url, "-O", filename] }
      let(:filename) { 'foo/bar.html' }
      context 'url = "http://example.com/"' do
        let(:url) { 'http://example.com/' }
        it { should == filename }
      end

      context 'url = "http://example.com/foo.html"' do
        let(:url) { 'http://example.com/foo.html' }
        it { should == filename }
      end
    end

    context 'has "--output-document" "foo/bar.html" as arguments' do
      let(:argv) { [url, "--output-document", filename] }
      let(:filename) { 'foo/bar.html' }
      context 'url = "http://example.com/"' do
        let(:url) { 'http://example.com/' }
        it { should == filename }
      end

      context 'url = "http://example.com/foo.html"' do
        let(:url) { 'http://example.com/foo.html' }
        it { should == filename }
      end
    end
  end
end
