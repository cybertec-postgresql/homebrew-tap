cask "pg_hardstorage" do
  version "1.1.1"

  on_macos do
    on_arm do
      url "https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v#{version}/pg_hardstorage_#{version}_darwin_arm64.tar.gz"
      sha256 "ca6d27bf7c826c2f3ebb55c6ce19457801d6cfc00117ce397755a91d6ee82454"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v#{version}/pg_hardstorage_#{version}_linux_amd64.tar.gz"
      sha256 "6c56e60ae608724d920e8335268ab4f30b64dcacadfb300820b31e4fc80c8059"
    end
    on_arm do
      url "https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v#{version}/pg_hardstorage_#{version}_linux_arm64.tar.gz"
      sha256 "9b1b2cb89ff6cb367bd20cb989b54a72a2bc3c5712c237b95ea881bc8640f97f"
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
