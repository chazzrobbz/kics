package Cx

import data.generic.terraform as tf_lib

CxPolicy[result] {
	resource := input.document[i].resource.aws_lambda_function[name]
	vars := resource.environment.variables

	containsAccessKey(vars[_])

	result := {
		"documentId": input.document[i].id,
		"resourceType": "aws_lambda_function",
		"resourceName": tf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("aws_lambda_function[%s].environment.variables", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "'environment.variables' doesn't contain access key",
		"keyActualValue": "'environment.variables' contains access key",
	}
}

containsAccessKey(var) {
	re_match("[A-Za-z0-9/+=]{40}", var)
}

containsAccessKey(var) {
	re_match("[A-Z0-9]{20}", var)
}
