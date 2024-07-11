# The Back-pocket MBD Demo #
Controlling a DC motor is perfect to show off a variety of products that are a part of Model Based Design.
The demo is setup to demo a range of products, as well as key modeling features.

The idea is you can open up these demos during any customer call and quickly demo how these products work.

### Relevant Products ###
  * Simulink, Simscape, Parallel Computing Toolbox, Simulink Design Optimization, Simulink Control Design, Embedded Coder, Simulink Test, Stateflow

### Simulink Platform Features ###
  * Data Inspector, Signal Editor, MultiSim with SimulationInput Objects, Model and Subsystem References, Data Dictionaries, Dashboards, Simulation Pacing, Masks and Callbacks, Apps, (Code) Perspective Views, Test Harnesses, Software-in-Loop Setup, Annotations and Areas


## Special Instructions
None

## Recording
Product                       | Topic                                   | Link
------------------------------| --------------------------------------- | -------------
Simulink and Simscape         | Using Simscape for Physical Modeling    | [Video](https://mathworks.sharepoint.com/:v:/s/aeg/EfuGQS5Bqg5VIgwoCzy88zMBDVNKyf6T4vGjfGFeJXV3cw?e=IcagrR&nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D)
Parallel Computing Toolbox    | Parameter Sweeps with Simulink and PCT  | <Coming Soon>
Simulink Design Optimization  | Estimate Parameters to match TestData   | [Video](https://mathworks.sharepoint.com/sites/aeg/_layouts/15/stream.aspx?uniqueId=a0e6a4b7%2Da171%2D5bc7%2D3102%2Dbfee16090db2&portal=%7B%22ha%22%3A%22classicstream%22%2C%22hm%22%3A%22view%22%7D&referrer=StreamWebApp%2EWeb&referrerScenario=AddressBarCopied%2Eview%2Ee5999077%2D509f%2D40ad%2D935d%2D62a899b8fa93&scenario=2)
Simulink Control Design       | PID Tuning with Plant Model             | [Video](https://mathworks.sharepoint.com/:v:/s/aeg/Eb1-tiAL1-lURNm2Z6Xkk1kBe1RPrtzo7r2k1VEr0bIzEg?e=HOdmNN&nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D)
Embedded Coder                | Going from Models to C code             | [Video](https://mathworks.sharepoint.com/:v:/s/aeg/Eb1-tiAL1-lURNm2Z6Xkk1kBe1RPrtzo7r2k1VEr0bIzEg?e=HOdmNN&nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D)
Simulink Test                 | Test your controller with Simulink Test | [Video](https://mathworks-my.sharepoint.com/:v:/p/smuckati/EWdcxTrI9XFY1jzIjfrdg_MBoz0K0tw_LIxajymUTPemmA?e=XVxgfh&nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D)
Stateflow                     | Adding supervisory logic with Stateflow | [Video](https://mathworks.sharepoint.com/:v:/s/aeg/EbrV8t6VRbdQu4PDOhPasrUB-0S1919D5tD1XSsOd0wgYw?e=3LpSDa&nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D)

## Contact
Sameer K Muckatira

## Relevant Industries
Automotive, Aerospace, Robotics, Power electronics, MedDevices with motors, Electromechanical Devices. 
Really, anyone adopting MBD

## Mirror to GitHub repo for GitHub Action to run

(https://github.com/yuxudong1024/dc-motor-with-pid-control/tree/master)

On the GitHub Repo, we need to [enable write permission](https://seekdavidlee.medium.com/how-to-fix-post-repos-check-runs-403-error-on-github-action-workflow-f2c5a9bb67d) to get test result

For some reason, the auto-mirror is stop working, so I roll back to manual mirror:

Setup the upstream mirror:

`system('git remote add upstream https://github.com/yuxudong1024/dc-motor-with-pid-control')`

Then, everytime mirror the upstream:

`system('git push upstream master')`

`system('git push --tags upstream')`