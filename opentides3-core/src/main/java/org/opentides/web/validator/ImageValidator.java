/*
   Licensed to the Apache Software Foundation (ASF) under one
   or more contributor license agreements.  See the NOTICE file
   distributed with this work for additional information
   regarding copyright ownership.  The ASF licenses this file
   to you under the Apache License, Version 2.0 (the
   "License"); you may not use this file except in compliance
   with the License.  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing,
   software distributed under the License is distributed on an
   "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
   KIND, either express or implied.  See the License for the
   specific language governing permissions and limitations
   under the License.    
 */
package org.opentides.web.validator;

import org.opentides.bean.AjaxUpload;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import org.springframework.web.multipart.MultipartFile;

/**
 * Ensures validity of photos uploaded
 * 
 * @author AJ
 * 
 */
@Component
public class ImageValidator implements Validator {

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.springframework.validation.Validator#supports(java.lang.Class)
	 */
	public boolean supports(Class<?> clazz) {
		return AjaxUpload.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object obj, Errors errors) {
		AjaxUpload ajaxUpload = (AjaxUpload) obj;
		MultipartFile attachment = ajaxUpload.getAttachment();
		ValidationUtils.rejectIfEmpty(errors, "attachment", "photo.image-required");
		if (attachment != null && !attachment.isEmpty()) {
			String contentType = attachment.getContentType().substring(0, 6);
			if (!"image/".equals(contentType)) {
				errors.rejectValue("attachment",
						"photo.invalid-file-type",
						"Invalid file. Profile Image must be in PNG, JPEG, GIF or BMP format.");
			} else if (attachment.getSize() > 1024 * 1024 * 10) {
					errors.rejectValue("attachment", "photo.invalid-file-size",
							"Invalid file. Maximum file size is 10 Megabytes");
			}
		}

	}

}
