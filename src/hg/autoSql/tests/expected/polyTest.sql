# polyTest.sql was originally generated by the autoSql program, which also 
# generated polyTest.c and polyTest.h.  This creates the database representation of
# an object which can be loaded and saved from RAM in a fairly 
# automatic way.

#A face
CREATE TABLE polygon (
    id int unsigned not null,	# Unique ID
    pointCount int not null,	# point count
    points longblob not null,	# Points list
              #Indices
    PRIMARY KEY(id)
);

#A 3-d object
CREATE TABLE polyhedron (
    id int unsigned not null,	# Unique ID
    names longblob not null,	# Name of this figure
    polygonCount int not null,	# Polygon count
    polygons longblob not null,	# Polygons
              #Indices
    PRIMARY KEY(id)
);