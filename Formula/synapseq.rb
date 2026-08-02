class Synapseq < Formula
  desc "Text-Driven Audio Sequencer for Brainwave Entrainment"
  homepage "https://github.com/synapseq-foundation/synapseq"
  version "4.41.0"
  license "GPL-3.0-or-later"

  base_url = "https://github.com/synapseq-foundation/synapseq/releases/download/v#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-macos-arm64.tar.gz"
      sha256 "0a9f6a88dcfeafda7948a40f42913f049b2cf360a0f38631fb6b56e0ebaf1dcd"
    else
      odie "SynapSeq is only available for macOS ARM64 (Apple Silicon)."
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-linux-arm64.tar.gz"
      sha256 "3ce80f6d9ab563aa6fe447ff105d8422c7bbd91329910e2cbbc6abd37b73352a"
    elsif Hardware::CPU.intel?
      url "#{base_url}/synapseq-v#{version}-linux-amd64.tar.gz"
      sha256 "3fc80f85007f6d7cbacc74e58b2e00d810c29f2c7f65a594529b23df58d5d0c0"
    else
      odie "Unsupported Linux architecture for SynapSeq."
    end
  else
    odie "Unsupported operating system for SynapSeq."
  end

  depends_on "ffmpeg"

  def install
    # Locate the SynapSeq binary (ignore .sha256 files)
    bin_path = Dir["synapseq*"].find { |f| File.basename(f) !~ /\.sha256$/ }
    raise "Binary not found in archive" unless bin_path

    chmod 0755, bin_path
    bin.install bin_path => "synapseq"
  end

  def caveats
    <<~EOS
      For documentation and examples, visit:
        https://github.com/synapseq-foundation/synapseq
    EOS
  end

  test do
    system "#{bin}/synapseq", "-version"
  end
end
