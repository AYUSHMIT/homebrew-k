class Kframework < Formula
  desc "K Framework Tools 5.0"
  bottle do
    root_url "https://github.com/kframework/k/releases/download/v5.0.0-499b4ac/"
    rebuild 68
    sha256 "36ca9ed05dc2535b9e0290b905ca42df3c6d7c3e7000b9fdfad4e1cc84c8d7bb" => :mojave
  end

  homepage ""
  url "https://github.com/kframework/k/releases/download/v5.0.0-499b4ac/kframework-5.0.0-src.tar.gz"
  sha256 "e39219a81289ee4e679dd713c5c2c544ff4e9f065e95cb4eff90b205b04234f1"
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
