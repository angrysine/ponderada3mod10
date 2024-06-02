#import cv2, numpy and matplotlib libraries
import cv2
import numpy as np

import math

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

    # Display the transformed image
    cv2.imshow("Transformed Image", img4)

    # Hold the window
    cv2.waitKey(0)

    # It is for removing/deleting created GUI window from screen and memory
    cv2.destroyAllWindows()

fazol(cv2.imread("murilo.jpeg", cv2.IMREAD_COLOR))
