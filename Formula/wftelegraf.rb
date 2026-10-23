require "formula"

class Wftelegraf < Formula
  homepage "https://www.wavefront.com"
  url "https://wavefront-cdn.s3.us-west-2.amazonaws.com/brew/telegraf-1.4.0.tar.gz"
  sha256 "2beeae27bae4117875061efa4f064d83f20b69e0471fa0f53732e46dd6348e69"

  def install
    bin.install "bin/telegraf"
    etc.install "etc/telegraf.conf"
  end

  def post_install
    # Create directory for additional user configurations
    (etc/"telegraf.d").mkpath
  end

  service do
    run [opt_bin/"telegraf", "-config", etc/"telegraf.conf", "-config-directory", etc/"telegraf.d"]
    keep_alive crashed: true
    working_dir var
    log_path var/"log/telegraf.log"
    error_log_path var/"log/telegraf.log"
  end
end
