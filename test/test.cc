#include <spline.h>
#include <gtest/gtest.h>


TEST(SplineTest, BasicInterpolation) {
    /* create arrays of x and y values*/
    double x[] = {-5.0,-4.0,-3.0,-2.0,-1.0,1.0,2.0,3.0,4.0,5.0};
    double y[10];
    int n = 10;
    for (int i = 0; i < n; i++) {
        y[i] = pow(x[i], 3.0);
    }

    /* create test position and interpolate */
    double xt = 0.0;
    double yt;
    spline(n, x, y, 1, &xt, &yt);

    /* Check that the interpolated value at x=0 is approximately 0 */
    EXPECT_NEAR(yt, 0.0, 1e-5);
}


int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
