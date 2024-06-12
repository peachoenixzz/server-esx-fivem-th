INSERT INTO `jobs` (name, label) VALUES
  ('offpolice','Off-Duty'),
  ('offambulance','Off-Duty'),
  ('offmechanic','Off-Duty')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('offpolice',0,'recruit','Recruit',100,'{}','{}'),
  ('offpolice',1,'officer','Officer',100,'{}','{}'),
  ('offpolice',2,'sergeant','Sergeant',100,'{}','{}'),
  ('offpolice',3,'lieutenant','Lieutenant',100,'{}','{}'),
  ('offpolice',4,'boss','Boss',100,'{}','{}'),
  ('offambulance',0,'ambulance','Ambulance',100,'{}','{}'),
  ('offambulance',1,'doctor','Medecin',100,'{}','{}'),
  ('offambulance',2,'chief_doctor','Medecin-chef',100,'{}','{}'),
  ('offambulance',3,'boss','Chirurgien',100,'{}','{}'),
  ('offmechanic',0,'recrue','Recrue',100,'{}','{}'),
  ('offmechanic',1,'novice','Novice',100,'{}','{}'),
  ('offmechanic',2,'Experimente','Experimente',100,'{}','{}'),
  ('offmechanic',3,'Chief','test',100,'{}','{}'),
  ('offmechanic',4,'boss','Boss',100,'{}','{}'),
;