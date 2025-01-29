#Notes - 2.Getting started
#Created: 28/01/2025
#Created by: JJ

#Basic commands#############################################
# Clear packages
detach("package:datasets", unload = TRUE)  # For base

# Clear plots
graphics.off()  # Clears plots, closes all graphics devices

# Clear console
cat("\014")  # ctrl+L

#Data types################################################
#Numbers are by default double
typeof(15) # commands to Check data type, output: "double"

#Character or a string of text are all Character
typeof("c") #Output: "Character"
typeof("a string of characters") #Output: "Character"

#Logical "TRUE", "T" or "FALSE", "F"
typeof(TRUE) #Output: "logical"
typeof(T) #Output: "logical"

#Vectors
v1 <- c(1,2,3,4)
is.vector(v1) #Output: TRUE
v2 <- c("a","b","c","d")
is.vector(v2) #Output: TRUE

#Matrix
#2 rows matrix, when not specify by row or by columns, it's default by columns
m1 <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2) 
m1 #Output:    [,1] [,2] [,3]
    #    [1,]    1    3    5
    #    [2,]    2    4    6

m2 <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, byrow = T) #specify by row
m2 #Output:      [,1] [,2] [,3]
    #      [1,]    1    2    3
    #      [2,]    4    5    6

#Array
a1 <- array(c(1:24),c(4,3,2)) #c(rows,columns, tables)
a1 #Output: , , 1

    #            [,1] [,2] [,3]
    #       [1,]    1    5    9
    #       [2,]    2    6   10
    #       [3,]    3    7   11
    #       [4,]    4    8   12

    #        , , 2

    #             [,1] [,2] [,3]
    #       [1,]   13   17   21
    #       [2,]   14   18   22
    #       [3,]   15   19   23
    #       [4,]   16   20   24

#Data frame
vNumeric   <- c(1, 2, 3)
vCharacter <- c("a", "b", "c")
vLogical   <- c(T, F, T)

df1 <- cbind(vNumeric, vCharacter, vLogical)
df1  # after combine, all values are Characters

df2 <- as.data.frame(cbind(vNumeric, vCharacter, vLogical))
df2  # kept their original data types

