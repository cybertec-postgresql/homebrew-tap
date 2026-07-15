cask "pg_hardstorage" do
  version "1.0.10"

  on_macos do
    on_arm do
      url "https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v#{version}/pg_hardstorage_#{version}_darwin_arm64.tar.gz"
      sha256 "7918e1cc452d0b0cd1cf389e105e29bd850d1c15462f071e345d53c917bb8701"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v#{version}/pg_hardstorage_#{version}_linux_amd64.tar.gz"
      sha256 "fc1605fe8803ec6ad78b0c904e2c341602fbbcc907b5067f3724abb35ef05a2a"
    end
    on_arm do
      url "https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v#{version}/pg_hardstorage_#{version}_linux_arm64.tar.gz"
      sha256 "c1a83244750b583dd291ee0dfd4e7e07d59a7bb89309c1ef876d8543ebdde146"
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
