from fastapi import APIRouter, UploadFile
import numpy as np
import cv2
import base64
import math

router = APIRouter()



def fazol(img):

    # Get the height and width of the image
    h, w = img.shape[:2]

    # Define the fractions for the L shape
    k1 = 0.2
    k2 = 0.2

    # Create a new array filled with zeros, with the same shape and data type as the original image
    img4 = np.zeros(img.shape, dtype=img.dtype)

    # Calculate the horizontal and vertical positions for the L shape
    a = math.floor(w * (1 - k1) / 2)
    b = a + math.floor(w * k1)

    # Copy the vertical part of the L shape
    img4[0:, a:b, :] = img[0:, a:b, :]

    # Copy the horizontal part of the L shape
    img4[h - math.floor(k1 * h):h, b:b + math.floor(w * k2), :] = img[h - math.floor(k1 * h):h, b:b + math.floor(w * k2), :]

    return img4


@router.post("/uploadfile/")
async def create_upload_file(file: UploadFile):
    contents = await file.read()
    file.close()
    nparr = np.fromstring(contents, np.uint8)
    img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    newImg = fazol(img)
     # line that fixed it
    _, encoded_img = cv2.imencode('.PNG', newImg)

    encoded_img = base64.b64encode(encoded_img)
    
    return {"file": encoded_img}

