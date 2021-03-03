class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-3948c10/"
    rebuild 82
    sha256 mojave: "4928c26cb48fafb0eb30f176aaae63b01b6b6867931384137d766b816e03daf4"
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.0.0-3948c10/kframework-5.0.0-src.tar.gz"
  sha256 "ff2b3c3f0190728df10c671833919058d7d52f457dd7dbfbb578afb1290495c3"
  depends_on "maven" => :build
  depends_on "cmake" => :build
  depends_on "boost" => :build
  depends_on "haskell-stack" => :build
  depends_on "libyaml"
  depends_on "jemalloc"
  depends_on "llvm@8"
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "z3"
  depends_on "pkg-config" => :build
  depends_on "bison"
  depends_on "flex"

  def install
    ENV["SDKROOT"] = MacOS.sdk_path
    ENV["DESTDIR"] = ""
    ENV["PREFIX"] = "#{prefix}"

    system "mvn", "package", "-DskipTests", "-Dproject.build.type=FastBuild"
    system "package/package"
  end

  test do
    system "true"
  end
end
