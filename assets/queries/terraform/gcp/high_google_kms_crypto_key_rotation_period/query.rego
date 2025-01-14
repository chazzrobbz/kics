package Cx

import data.generic.common as common_lib
import data.generic.terraform as tf_lib

CxPolicy[result] {
	cryptoKey := input.document[i].resource.google_kms_crypto_key[name]
	rotationP := substring(cryptoKey.rotation_period, 0, count(cryptoKey.rotation_period) - 1)
	to_number(rotationP) > 7776000

	result := {
		"documentId": input.document[i].id,
		"resourceType": "google_kms_crypto_key",
		"resourceName": tf_lib.get_resource_name(cryptoKey, name),
		"searchKey": sprintf("resource.google_kms_crypto_key[%s].rotation_period", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "'google_kms_crypto_key.rotation_period' is less or equal to 7776000",
		"keyActualValue": "'google_kms_crypto_key.rotation_period' is higher than 7776000",
	}
}

CxPolicy[result] {
	cryptoKey := input.document[i].resource.google_kms_crypto_key[name]

	not common_lib.valid_key(cryptoKey,"rotation_period")

	result := {
		"documentId": input.document[i].id,
		"resourceType": "google_kms_crypto_key",
		"resourceName": tf_lib.get_resource_name(cryptoKey, name),
		"searchKey": sprintf("resource.google_kms_crypto_key[%s]", [name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "'google_kms_crypto_key.rotation_period' is set",
		"keyActualValue": "'google_kms_crypto_key.rotation_period' is undefined",
	}
}
