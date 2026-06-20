class Synapseq < Formula
  desc "Text-Driven Audio Sequencer for Brainwave Entrainment"
  homepage "https://github.com/synapseq-foundation/synapseq"
  version "4.3.0"
  license "GPL-3.0-or-later"

  base_url = "https://github.com/synapseq-foundation/synapseq/releases/download/v#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-macos-arm64.tar.gz"
      sha256 "5415e9604002662fdd6de1314fa474d65caf48067b10dea99cea4328e2f5e523"
    else
      odie "SynapSeq is only available for macOS ARM64 (Apple Silicon)."
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-linux-arm64.tar.gz"
      sha256 "0a1afe5598a8f3b95cd4ea141a868af80a6b7a6a5f8ad08df73fe27fd65bfd92"
    elsif Hardware::CPU.intel?
      url "#{base_url}/synapseq-v#{version}-linux-amd64.tar.gz"
      sha256 "af22b76ee24aa2c17942784fd621ed6d921732ff26f867546f9785ea8a253282"
    else
      odie "Unsupported Linux architecture for SynapSeq."
    end
  else
    odie "Unsupported operating system for SynapSeq."
  end

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
