/*
 * Swagger Petstore
 *
 * No description provided (generated by Openapi Generator https://github.com/openapitools/openapi-generator)
 *
 * API version: 1.0.0
 * Generated by: OpenAPI Generator (https://openapi-generator.tech)
 */

package openapi

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

// CreatePets - Create a pet
func CreatePets(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{})
}

// ListPets - List all pets
func ListPets(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{})
}

// ShowPetById - Info for a specific pet
func ShowPetById(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{})
}
