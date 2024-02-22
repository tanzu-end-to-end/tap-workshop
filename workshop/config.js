const fs = require('fs');
const yaml = require('js-yaml');
const { spawnSync } = require('child_process');

function initialize(workshop) {
    workshop.load_workshop();

    let fileContents = fs.readFileSync('/home/eduk8s/.kube/config');
    let data;
    try {
        data = yaml.safeLoad(fileContents);
    } catch(err) {
        //Deprecated in js-yaml 4, so try load
        data = yaml.load(fileContents);
    }

    workshop.data_variable('user_token', data.users[0].user.token);
}

exports.default = initialize;

module.exports = exports.default;