import { acceptance } from "helpers/qunit-helpers";

acceptance("Teachable", { loggedIn: true });

test("Teachable works", async assert => {
  await visit("/admin/plugins/teachable");

  assert.ok(false, "it shows the Teachable button");
});
