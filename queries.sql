
SELECT * from animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-1-1' AND '2019-12-31';
SELECT * from animals WHERE neutered IS TRUE AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name IN ('Agumon','Pikachu');
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered IS TRUE;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg >= 10.5 AND weight_kg <= 17.3;

/* Update */

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species from animals;
ROLLBACK;
SELECT species from animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name like '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * from animals;
COMMIT;
SELECT * from animals;

BEGIN;
DELETE FROM animals;
SELECT * from animals;
ROLLBACK;
SELECT * from animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-1-1';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * from animals;
ROLLBACK TO SP1;
SELECT * from animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * from animals;
COMMIT;
SELECT * from animals;

SELECT COUNT(name) from animals;
SELECT COUNT(name) from animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) from animals;
SELECT neutered, MAX(escape_attempts) from animals GROUP BY neutered;
SELECT species, MAX(weight_kg), MIN(weight_kg) from animals GROUP BY species;
SELECT species, AVG(escape_attempts) from animals WHERE date_of_birth BETWEEN '1990-1-1' AND '2000-12-31' GROUP BY species;


/* queries using JOIN */
/* animals belong to Melody Pond */
SELECT name, full_name FROM animals
INNER JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Melody Pond';

/* all animals that are pokemon */
SELECT animals.name, species.name FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

/* Number animals are there per species */
SELECT species.name, COUNT(*) FROM animals
FULL JOIN species ON animals.species_id = species.id
GROUP BY species.name;

/* all owners and their animals, including those who don't own any animal */
SELECT full_name, name FROM animals RIGHT JOIN owners ON animals.owners_id = owners.id;

/* Digimon owned by Jennifer Orwell. */
SELECT species.name, animals.name, owners.full_name FROM animals
INNER JOIN species ON animals.species_id = species.id
INNER JOIN owners ON animals.owners_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

/* all animals owned by Dean Winchester that haven't tried to escape. */
SELECT animals.name, animals.escape_attempts FROM animals
INNER JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

/* owns the most animals */
SELECT owners.full_name, COUNT(animals.name) FROM animals
JOIN owners ON animals.owners_id = owners.id
GROUP BY owners.full_name ORDER BY count DESC LIMIT 1;
