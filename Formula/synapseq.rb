class Synapseq < Formula
  desc "Text-Driven Audio Sequencer for Brainwave Entrainment"
  homepage "https://github.com/synapseq-foundation/synapseq"
  version "4.1.1"
  license "GPL-2.0-only"

  base_url = "https://github.com/synapseq-foundation/synapseq/releases/download/v#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-macos-arm64.tar.gz"
      sha256 "ede1f6c93ebe4b30f078a27a873f6e0f02a078d2e1455ab52215e63f2da4a223"
    else
      odie "SynapSeq is only available for macOS ARM64 (Apple Silicon)."
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-linux-arm64.tar.gz"
      sha256 "ae7ea40fb782bb204c34d96245c717242f379c02a69bdd7fbbd1d7f1ba2474cf"
    elsif Hardware::CPU.intel?
      url "#{base_url}/synapseq-v#{version}-linux-amd64.tar.gz"
      sha256 "97b1716aae7c6313b50e93b9e32e07b5563fde56b3f13dae218401ca2ed992ab"
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