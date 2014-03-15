-- Create the user account and grant it all privileges on the databases.
grant all PRIVILEGES on gmd_development.* to gmd@localhost identified by 'gmd';
grant all PRIVILEGES on gmd_test.* to gmd@localhost identified by 'gmd';
grant all PRIVILEGES on gmd.* to gmd@localhost identified by 'gmd';
