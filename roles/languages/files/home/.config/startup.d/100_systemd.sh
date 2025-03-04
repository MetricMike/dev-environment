#! /bin/bash

systemctl --user import-environment PATH
systemctl --user daemon-reload