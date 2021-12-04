module.exports = ({ env }) => ({
  auth: {
    secret: env('ADMIN_JWT_SECRET', '7e844a922dd47de0dce84cab50dbfe4b'),
  },
});
