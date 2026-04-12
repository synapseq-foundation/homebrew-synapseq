class Synapseq < Formula
  desc "Text-Driven Audio Sequencer for Brainwave Entrainment"
  homepage "https://github.com/synapseq-foundation/synapseq"
  version "4.1.0"
  license "GPL-2.0-only"

  base_url = "https://github.com/synapseq-foundation/synapseq/releases/download/v#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-macos-arm64.tar.gz"
      sha256 "d1823817d47645b165343438338089d8b93b2e38d83d226569cf5a109d486940"
    else
      odie "SynapSeq is only available for macOS ARM64 (Apple Silicon)."
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "#{base_url}/synapseq-v#{version}-linux-arm64.tar.gz"
      sha256 "4cdc8c0696e575cefdc005f3d1a1346caa30c678074e6242fd1eba1fa3f30d6c"
    elsif Hardware::CPU.intel?
      url "#{base_url}/synapseq-v#{version}-linux-amd64.tar.gz"
      sha256 "e89dbf464acce74cd495f2593fc60b7a02f2850bedc544e2faf17362b137711e"
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