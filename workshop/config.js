const fs = require('fs');
const yaml = require('js-yaml');
const { spawnSync } = require('child_process');

function initialize(workshop) {
  workshop.load_workshop();

  let namespace = process.env['SESSION_NAMESPACE']
  kubectl = spawnSync('kubectl', ['-n', namespace, 'get', 'harborproject', namespace, '-o', 'jsonpath="{.status.projectid}"'], {timeout: 30000, encoding: "utf8"});

  if(kubectl.status == 0) {
    let project_id = kubectl.stdout.toString().replace(/\"/g,"");
    console.log(`Got harbor project id: ${project_id}` );
    workshop.data_variable('harbor_project_id', project_id);
  } else {
    console.error("Error getting project id.");
    console.error(`stdout: ${kubectl.stdout}`)
    console.error(`stderr: ${kubectl.stderr}`);
  }
}

exports.default = initialize;

module.exports = exports.default;