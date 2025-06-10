DROP SCHEMA IF EXISTS partie1 CASCADE;
CREATE SCHEMA partie1;
SET SCHEMA ‘partie1’;



CREATE TABLE _candidat (
no_candidat INT NOT NULL,
classement VARCHAR(7) NULL,
bousier_lycée VARCHAR(40),
profil_candidat VARCHAR(45),
etablissement VARCHAR(75),
dept_etablissement VARCHAR(20),
ville_etablissement VARCHAR(30),
niveau_etude VARCHAR(45),
type_formation_prec VARCHAR(70),
serie_prec VARCHAR(95),
dominante_prec VARCHAR(50),
specialite_prec VARCHAR(90),
LV1 VARCHAR(55),
LV2 VARCHAR(55),
CONSTRAINT _candidat_pk PRIMARY KEY(no_candidat)
);

CREATE TABLE _etudiant (
code_nip VARCHAR(20) NOT NULL,
cat_socio_etu VARCHAR(40),
cat_socio_parent VARCHAR(40),
bourse_superieur BOOLEAN,
mention_bac VARCHAR(40),
dominante_bac VARCHAR(70),
specialite_bac VARCHAR(80),
mois_annee_obtention_bac VARCHAR(7),
CONSTRAINT _etudiant_pk PRIMARY KEY(code_nip)
);

CREATE TABLE _individu (
id_individu INT NOT NULL,
code_nip VARCHAR(11) NOT NULL,
no_candidat INT NOT NULL,
nom VARCHAR(15),
prenom VARCHAR(15),
date_naissance DATE,
code_postal VARCHAR(6),
ville VARCHAR(30),
sexe CHAR,
nationalite VARCHAR(20),
INE VARCHAR(10),
CONSTRAINT individu_pk PRIMARY KEY(id_individu, no_candidat, code_nip)
);

CREATE TABLE _semestre (
id_semestre INT NOT NULL,
num_semestre VARCHAR(5),
annee_univ VARCHAR(9),
CONSTRAINT _semestre_pk PRIMARY KEY(id_semestre)
);

CREATE TABLE _inscription (
id_semestre INT NOT NULL,
code_nip VARCHAR(11) NOT NULL,
groupe_tp VARCHAR(2),
amenagement_evaluation VARCHAR(20),
CONSTRAINT _inscription_pk PRIMARY KEY(id_semestre, code_nip)
);

CREATE TABLE _module (
id_module VARCHAR(5) NOT NULL,
libelle_module VARCHAR(105),
ue VARCHAR(2),
CONSTRAINT _module_pk PRIMARY KEY(id_module)
);

CREATE TABLE _programme (
id_module VARCHAR(5) NOT NULL,
id_semestre INT NOT NULL,
coefficient REAL,
CONSTRAINT _programme_pk PRIMARY KEY(id_module, id_semestre)
);

CREATE TABLE _resultat (
code_nip VARCHAR(11) NOT NULL,
id_semestre INT NOT NULL,
id_module VARCHAR(5) NOT NULL,
moyenne REAL,
CONSTRAINT _resultat_pk PRIMARY KEY(code_nip, id_semestre, id_module)
);


ALTER TABLE _individu
	ADD CONSTRAINT _individu_fk1 FOREIGN KEY (code_nip)
REFERENCES _etudiant(code_nip);
	

ALTER TABLE _individu
	ADD CONSTRAINT _individu_fk2 FOREIGN KEY (no_candidat) REFERENCES _candidat(no_candidat);


ALTER TABLE _inscription
	ADD CONSTRAINT _inscription_fk1 FOREIGN KEY(code_nip)
REFERENCES _etudiant(code_nip);


ALTER TABLE _inscription
	ADD CONSTRAINT _inscription_fk2 FOREIGN KEY(id_semestre)
REFERENCES _semestre(id_semestre);


ALTER TABLE _programme
	ADD CONSTRAINT _programme_fk1 FOREIGN KEY (id_module)
REFERENCES _module(id_module);


ALTER TABLE _programme
	ADD CONSTRAINT _programme_fk2 FOREIGN KEY (id_semestre)
REFERENCES _semestre(id_semestre);


ALTER TABLE _resultat
	ADD CONSTRAINT _resultat_fk1 FOREIGN KEY (code_nip)
REFERENCES _etudiant(code_nip);


ALTER TABLE _resultat
	ADD CONSTRAINT _resultat_fk2 FOREIGN KEY(id_semestre)
REFERENCES _semestre(id_semestre);


ALTER TABLE _resultat
	ADD CONSTRAINT _resultat_fk3 FOREIGN KEY(id_module)
REFERENCES _module(id_module);
