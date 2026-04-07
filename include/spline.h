
#ifndef LIBSPLINE_H_INCLUDED
#define LIBSPLINE_H_INCLUDED

#ifdef __cplusplus
extern "C" {
#endif

#define LIBSPLINE_VERSION_MAJOR 0
#define LIBSPLINE_VERSION_MINOR 3
#define LIBSPLINE_VERSION_PATCH 0


void libspline_spline(int n0, double *x0, double *y0, 
			int n1, double *x1, double *y1);
#ifdef __cplusplus
} // extern "C"

namespace spline {

inline void spline(int n0, double* x0, double* y0,
                   int n1, double* x1, double* y1) {
    ::libspline_spline(n0, x0, y0, n1, x1, y1);
}

class Spline {
	public:
		Spline(int,double*,double*);
		Spline(const Spline &);
		~Spline();
		void Interpolate(int,double*,double*);
	
		int n_;
		double *a_, *b_, *c_, *d_;
		double *x_, *y_;
		bool del_;
};

} // namespace spline
#endif // __cplusplus
#endif // LIBSPLINE_H_INCLUDED
