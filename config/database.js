module.exports = ({ env }) => ({
  connection: {
    client: "mysql",
    connection: {
      host: env(
        "DATABASE_HOST",
        "oaci.cp4gcmpufrc5.sa-east-1.rds.amazonaws.com"
      ),
      port: env.int("DATABASE_PORT", 3306),
      database: env("DATABASE_NAME", "unmsm-v2"),
      user: env("DATABASE_USERNAME", "admin"),
      password: env("DATABASE_PASSWORD", "oaci12345"),
      ssl: env.bool("DATABASE_SSL", true),
    },
  },
});
