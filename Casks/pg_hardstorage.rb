cask "pg_hardstorage" do
  version "1.0.14"

  on_macos do
    on_arm do
      url "https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v#{version}/pg_hardstorage_#{version}_darwin_arm64.tar.gz"
      sha256 "250798c8e89cc96172bcfc142670fb1172c75460f0b79a10551b7cf9524c8a50"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v#{version}/pg_hardstorage_#{version}_linux_amd64.tar.gz"
      sha256 "ae03044d815ed2a70faa93fb2ac7ed9913c06a385dda1f497aed5d3805cfef35"
    end
    on_arm do
      url "https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v#{version}/pg_hardstorage_#{version}_linux_arm64.tar.gz"
      sha256 "827552525762c00e9748116e35aa867d777172c55e9c6f1b4ae40ff8ff5dc56a"
    end
  end

  name "pg_hardstorage"
  desc "PostgreSQL backup over the replication protocol — WAL streaming, dedup, envelope encryption, signed manifests"
  homepage "https://github.com/cybertec-postgresql/pg_hardstorage"

  binary "pg_hardstorage"

  postflight do
    if OS.mac?
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", "#{staged_path}/pg_hardstorage"]
    end
  end

  caveats <<~EOS
    pg_hardstorage connects to PostgreSQL over the replication protocol
    and needs no local PostgreSQL server. If you want the psql client
    locally, install it separately:
      brew install libpq           # client only
      brew install postgresql@18   # full server

    Docs: https://docs.pghardstorage.org
  EOS
end
