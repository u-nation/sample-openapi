package org.openapitools.model

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonProperty
import javax.validation.constraints.DecimalMax
import javax.validation.constraints.DecimalMin
import javax.validation.constraints.Max
import javax.validation.constraints.Min
import javax.validation.constraints.NotNull
import javax.validation.constraints.Pattern
import javax.validation.constraints.Size

/**
 * 
 * @param id 
 * @param name 
 * @param tag 
 */
data class Pet (

        @get:NotNull 
        @JsonProperty("id") val id: kotlin.Long,

        @get:NotNull 
        @JsonProperty("name") val name: kotlin.String,

        @JsonProperty("tag") val tag: kotlin.String? = null
) {

}

