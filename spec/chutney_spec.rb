# frozen_string_literal: true

require 'chutney'

describe Chutney::ChutneyLint do
  subject { Chutney::ChutneyLint.new }

  it 'has a version number' do
    expect(Chutney::VERSION).not_to be nil
  end

  describe '#initialize' do
    it 'creates an instance' do
      expect(subject).not_to be_nil
    end

    it 'has an empty list of files if none are given' do
      expect(subject.files).to eq []
    end

    it 'has a list of files given on initialization' do
      alt_subject = Chutney::ChutneyLint.new('a', 'b')
      expect(alt_subject.files).to eq %w[a b]
    end

    it 'initializes a results hash' do
      expect(subject.results).to eq({})
    end

    it 'sets the load path for I18n' do
      expect(I18n.load_path).not_to eq []
    end

    context 'configuration' do
      it 'loads the configuration from a file' do
        expect(subject.configuration).not_to be_nil
        expect(subject.configuration).to respond_to :[]
      end

      it 'allows the configuration to be set explicitly' do
        config = { 'BackgroundDoesMoreThanSetup' => { 'Enabled' => true } }
        subject.configuration = config
        expect(subject.configuration).to be config
      end

      it 'controls the available linters' do
        subject.configuration = {}
        expect(subject.linters).to be_empty
      end

      it 'enables linters to be activated' do
        config = { 'BackgroundDoesMoreThanSetup' => { 'Enabled' => true } }
        subject.configuration = config
        expect(subject.linters).to eq [Chutney::BackgroundDoesMoreThanSetup]
      end
    end

    context 'linting' do
      it 'aliases analyse and analyze' do
        expect(subject).to respond_to :analyse
        expect(subject).to respond_to :analyze
      end
    end
  end
end
