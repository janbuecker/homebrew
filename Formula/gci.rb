class Gci < Formula
  url "https://github.com/daixiang0/gci.git",
        tag:      "v0.13.5",
        revision: "dca258a399bf32ab20c73ab4edb726cfff7224ef"
  head "https://github.com/daixiang0/gci.git", branch: "master"

  depends_on "go"

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version}
      -X main.commit=#{Utils.git_short_head(length: 7)}
      -X main.date=#{time.iso8601}
    ]

    system "go", "build", *std_go_args(ldflags:), "./"
  end

  test do
    str_version = shell_output("#{bin}/gci --version")
    assert_match(/gci version #{version}/, str_version)

    str_help = shell_output("#{bin}/gci --help")
    assert_match "Usage:", str_help
    assert_match "Available Commands:", str_help
  end
end
