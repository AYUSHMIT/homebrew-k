class Kframework < Formula
  desc "K Framework Tools 5.0"
  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.1.158/kframework-5.1.158-src.tar.gz"
  sha256 "eb8968648f3c89d53ad4ebca4e732783241ff59ab4d02dac52494316f730f33f"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.1.158/"
    rebuild 53
    sha256 big_sur: "03be546db5682dd43b1713078aa1c635d77c9afe4531c866dd2dc829d5832610"
  end
  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "haskell-stack" => :build
  depends_on "maven" => :build
  depends_on "pkg-config" => :build
  depends_on "bison"
  depends_on "flex"
  depends_on "gmp"
  depends_on "jemalloc"
  depends_on "libyaml"
  depends_on "llvm@12"
  depends_on "mpfr"
  depends_on "z3"

  def install
    ENV["SDKROOT"] = MacOS.sdk_path
    ENV["DESTDIR"] = ""
    ENV["PREFIX"] = prefix.to_s

    # Unset MAKEFLAGS for `stack setup`.
    # Prevents `install: mkdir ... ghc-7.10.3/lib: File exists`
    # See also: https://github.com/brewsci/homebrew-science/blob/bb52ecc66b6f9fad4d281342139189ae81d7c410/Formula/tamarin-prover.rb#L27
    ENV.deparallelize do
      cd "haskell-backend/src/main/native/haskell-backend" do
        system "stack", "setup"
      end
    end

    system "mvn", "package", "-DskipTests", "-Dproject.build.type=FastBuild"
    system "package/package"
  end

  test do
    system "true"
  end
end
