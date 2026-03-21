class Synapseq < Formula
  desc "Text-Driven Audio Sequencer for Brainwave Entrainment"
  homepage "https://github.com/synapseq-foundation/synapseq"
  version "4.0.2"
  license "GPL-2.0-only"

  base_url = "https://github.com/synapseq-foundation/synapseq/releases/download/v#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-macos-arm64.tar.gz"
      sha256 "b3a9f2c87775fbf8ba8c3adf95baf3fc9bbefdc2fe9d9d41cefac6d8022bd98f"
    else
      odie "SynapSeq is only available for macOS ARM64 (Apple Silicon)."
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-linux-arm64.tar.gz"
      sha256 "73613aa52fba3ef949ed6a47a12d409db4728115fc9ae2be4703f61576234b1f"
    elsif Hardware::CPU.intel?
      url "#{base_url}/synapseq-v#{version}-linux-amd64.tar.gz"
      sha256 "92db302e2d5e3310e841d53e557803dc945125c126b7a2f268b99a28230fae9e"
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