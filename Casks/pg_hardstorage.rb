cask "pg_hardstorage" do
  version "1.0.9"

  on_macos do
    on_arm do
      url "https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v#{version}/pg_hardstorage_#{version}_darwin_arm64.tar.gz"
      sha256 "c7ea0f046ae3566e76ac03c145fd5b4b99abf7b2c764e88ab2ce0f433c97d54f"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v#{version}/pg_hardstorage_#{version}_linux_amd64.tar.gz"
      sha256 "bea0a24cd63d705ed5e605c0a0746a848e28c3f4825edfcb07852a4d0ba5b142"
    end
    on_arm do
      url "https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v#{version}/pg_hardstorage_#{version}_linux_arm64.tar.gz"
      sha256 "1a0a038597a73aa0de717c6c38b337067b32a09ea36380983814276bf021f41b"
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
