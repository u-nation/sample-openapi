/**
* Swagger Petstore
* No description provided (generated by Openapi Generator https://github.com/openapitools/openapi-generator)
*
* The version of the OpenAPI document: 1.0.0
* 
*
* NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
* https://openapi-generator.tech
* Do not edit the class manually.
*/
package org.openapitools.client.models


import com.squareup.moshi.Json
/**
 * 
 * @param id 
 * @param name 
 * @param tag 
 */

data class Pet (
    @Json(name = "id")
    val id: kotlin.Long,
    @Json(name = "name")
    val name: kotlin.String,
    @Json(name = "tag")
    val tag: kotlin.String? = null
) 



