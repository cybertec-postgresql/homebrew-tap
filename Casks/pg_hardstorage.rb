cask "pg_hardstorage" do
  version "1.0.7"

  on_macos do
    on_arm do
      url "https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v#{version}/pg_hardstorage_#{version}_darwin_arm64.tar.gz"
      sha256 "28bac2b21539f9a0df027f882bc465665e86af3c51e128c77561c9dbdfe66862"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v#{version}/pg_hardstorage_#{version}_linux_amd64.tar.gz"
      sha256 "ad1ea8dce7b7816c88fe3b34a4056d7e48e670038392a23c706f7611d398c9b5"
    end
    on_arm do
      url "https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v#{version}/pg_hardstorage_#{version}_linux_arm64.tar.gz"
      sha256 "88be62ccc86bd47ff716e34f4307a2e9f7f8f6fb88017103a4b1946c8f0772f2"
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
