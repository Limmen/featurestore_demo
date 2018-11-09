# Hopsworks Feature Store Integration Test

## Usage

- First, build a VM with featurestore support, 
- then create a project with the featurestore service enabled.
- run `./run.sh ports` to find which exported port hopsworks is running on
- check inside the project what id it got and what id it's featurestore got
- create the sample datasets by running the notebook in `./sample_data/`
- build the fat-jar by running `cd feature_engineering_spark; sbt assembly`
- upload the fat-jar to the project's `Resources` folder
- create a new dataset in the project called `sample_data`
- upload the sample datasets (e.g alerts.csv, hipo.csv, kyc.csv, police_reports.csv etc) to sample_data
- create the sample jobs by running:
```sh
$ ./feature_engineering_spark/create_jobs.sh <PORT> <PROJECTNAME> <PROJECTID>
```
e.g:
```sh
$ ./feature_engineering_spark/create_jobs.sh 55354 hopsworksdemo 8
```
- create the sample featuregroups by running:
```sh
$ ./feature_engineering_spark/create_fgs.sh <PORT> <PROJECTNAME> <PROJECTID> <FEATURESTOREID> <JOBIDINIT>
```
Where <JOBIDINT> is the id of the first job (it is assumed that the rest of the jobs follow with consecutive id's, if you created a fresh VM/project this will be `1`)
e.g:
```sh
$ ./feature_engineering_spark/create_fgs.sh 55354 "hopsworksdemo" 8 3 1
```
