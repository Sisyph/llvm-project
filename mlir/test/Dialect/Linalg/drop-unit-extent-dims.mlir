// RUN: mlir-opt %s -split-input-file -pass-pipeline="builtin.module(func.func(linalg-fold-unit-extent-dims))" | FileCheck %s

#accesses = [
  affine_map<(i, j, k, l, m) -> (i, k, m)>,
  affine_map<(i, j, k, l, m) -> ()>,
  affine_map<(i, j, k, l, m) -> (i, k, j, l, m)>
]

#trait = {
  iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel"],
  indexing_maps = #accesses,
  library_call = "some_external_func"
}

func.func @drop_one_trip_loops(%arg0 : tensor<?x1x?xf32>, %arg1 : f32, %shape: tensor<?x1x?x1x?xf32>) -> tensor<?x1x?x1x?xf32> {
  %0 = linalg.generic #trait
     ins(%arg0, %arg1 : tensor<?x1x?xf32>, f32)
    outs(%shape : tensor<?x1x?x1x?xf32>) {
       ^bb0(%arg2 : f32, %arg3 : f32, %arg4 : f32) :
         linalg.yield %arg3 : f32
       } -> tensor<?x1x?x1x?xf32>
  return %0 : tensor<?x1x?x1x?xf32>
}
//   CHECK-DAG: #[[$MAP1:.*]] = affine_map<(d0, d1, d2) -> (d0, d2)>
//   CHECK-DAG: #[[$MAP2:.*]] = affine_map<(d0, d1, d2) -> ()>
//   CHECK-DAG: #[[$MAP3:.*]] = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
// CHECK-LABEL: func @drop_one_trip_loops
//       CHECK: tensor.collapse_shape %{{.*}} {{\[}}[0, 1], [2]]
//       CHECK: linalg.generic
//  CHECK-SAME:   indexing_maps = [#[[$MAP1]], #[[$MAP2]], #[[$MAP3]]]
//  CHECK-SAME:   iterator_types = ["parallel", "parallel", "parallel"]
//       CHECK: tensor.expand_shape %{{.*}} {{\[}}[0, 1], [2, 3], [4]]

// -----

#accesses = [
  affine_map<(i, j, k, l, m) -> (i, k, m)>,
  affine_map<(i, j, k, l, m) -> (i, k, j, l, m)>
]

#trait = {
  iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel"],
  indexing_maps = #accesses,
  library_call = "some_external_func"
}

func.func @drop_one_trip_loops_indexed
  (%arg0 : tensor<?x1x?xi32>, %shape: tensor<?x1x?x1x?xi32>) -> tensor<?x1x?x1x?xi32>
{
  %0 = linalg.generic #trait
     ins(%arg0 : tensor<?x1x?xi32>)
    outs(%shape: tensor<?x1x?x1x?xi32>) {
       ^bb0(%arg6 : i32, %arg7 : i32) :
         %idx0 = linalg.index 0 : index
         %idx1 = linalg.index 1 : index
         %idx2 = linalg.index 2 : index
         %idx3 = linalg.index 3 : index
         %idx4 = linalg.index 4 : index
         %1 = arith.addi %idx0, %idx1 : index
         %2 = arith.subi %1, %idx2 : index
         %3 = arith.subi %2, %idx3 : index
         %4 = arith.addi %3, %idx4 : index
         %5 = arith.index_cast %4 : index to i32
         %6 = arith.addi %5, %arg6 : i32
         linalg.yield %6 : i32
       } -> tensor<?x1x?x1x?xi32>
  return %0 : tensor<?x1x?x1x?xi32>
}
// The subtractions disappear the access map of the output tensor maps its unit
// dimensions 1 and 3 to the index dimensions 2 and 3.
// CHECK-LABEL: func @drop_one_trip_loops_indexed
//       CHECK:   linalg.generic
//       CHECK:   ^{{.+}}(
//  CHECK-SAME:     %[[ARG4:[a-zA-Z0-9]+]]: i32, %{{.*}}: i32)
//       CHECK:     %[[IDX0:.+]] = linalg.index 0 : index
//       CHECK:     %[[IDX1:.+]] = linalg.index 1 : index
//       CHECK:     %[[IDX2:.+]] = linalg.index 2 : index
//       CHECK:     %[[T3:.+]] = arith.addi %[[IDX0]], %[[IDX1]]
//       CHECK:     %[[T4:.+]] = arith.addi %[[T3]], %[[IDX2]]
//       CHECK:     %[[T5:.+]] = arith.index_cast %[[T4]] : index to i32
//       CHECK:     %[[T6:.+]] = arith.addi %[[T5]], %[[ARG4]] : i32
//       CHECK:     linalg.yield %[[T6]] : i32

// -----

#map0 = affine_map<(i, j) -> (i, j)>
#access = [#map0, #map0]
#trait = {
  iterator_types = ["parallel", "parallel"],
  indexing_maps = #access,
  library_call = "some_external_func"
}

func.func @drop_all_loops(%arg0 : tensor<1x1xf32>) -> tensor<1x1xf32>
{
  %0 = linalg.generic #trait
     ins(%arg0 : tensor<1x1xf32>)
    outs(%arg0 : tensor<1x1xf32>) {
       ^bb0(%arg1: f32, %arg2: f32) :
         linalg.yield %arg1 : f32
       } -> tensor<1x1xf32>
  return %0 : tensor<1x1xf32>
}
//       CHECK: #[[$MAP0:.*]] = affine_map<() -> ()>
// CHECK-LABEL: func @drop_all_loops
//       CHECK:   tensor.collapse_shape %{{.*}} []
//       CHECK:   linalg.generic
//  CHECK-SAME:     indexing_maps = [#[[$MAP0]], #[[$MAP0]]]
//  CHECK-SAME:     iterator_types = []

// -----

#map0 = affine_map<(i, j) -> (i, j)>
#access = [#map0, #map0]
#trait = {
  iterator_types = ["parallel", "parallel"],
  indexing_maps = #access,
  library_call = "some_external_func"
}

func.func @drop_all_loops_indexed
  (%arg0 : tensor<1x1xi32>) -> tensor<1x1xi32>{
  %0 = linalg.generic #trait
     ins(%arg0 : tensor<1x1xi32>)
    outs(%arg0 : tensor<1x1xi32>) {
       ^bb0(%arg3: i32, %arg4: i32) :
         %idx0 = linalg.index 0 : index
         %idx1 = linalg.index 1 : index
         %1 = arith.addi %idx0, %idx1 : index
         %2 = arith.index_cast %1 : index to i32
         %3 = arith.addi %2, %arg3 : i32
         linalg.yield %3 : i32
       } -> tensor<1x1xi32>
  return %0 : tensor<1x1xi32>
}

// CHECK-LABEL: func @drop_all_loops_indexed
//       CHECK:   linalg.generic
//       CHECK:   ^{{.+}}(%[[ARG1:.+]]: i32, %[[ARG2:.+]]: i32)
//       CHECK:     linalg.yield %[[ARG1]] : i32

// -----

#accesses = [
  affine_map<(d0) -> (0, d0)>,
  affine_map<(d0) -> (d0)>
]

#trait = {
  indexing_maps = #accesses,
  iterator_types = ["parallel"],
  library_call = "some_external_fn"
}

func.func @leading_dim_1_canonicalization(%arg0: tensor<1x5xf32>, %shape: tensor<5xf32>) -> tensor<5xf32> {
  %0 = linalg.generic #trait
     ins(%arg0 : tensor<1x5xf32>)
    outs(%shape : tensor<5xf32>) {
  ^bb0(%arg2: f32, %arg3: f32):
    linalg.yield %arg2 : f32
  } -> tensor<5xf32>
  return %0 : tensor<5xf32>
}
//   CHECK: #[[$MAP1:.*]] = affine_map<(d0) -> (d0)>

// CHECK-LABEL: func @leading_dim_1_canonicalization
//       CHECK:   tensor.collapse_shape %{{.*}} {{\[}}[0, 1]]
//       CHECK:   linalg.generic
//  CHECK-SAME:     indexing_maps = [#[[$MAP1]], #[[$MAP1]]]
//  CHECK-SAME:     iterator_types = ["parallel"]

// -----

#accesses = [
  affine_map<(d0, d1) -> (0, d1)>,
  affine_map<(d0, d1) -> (d0, 0)>,
  affine_map<(d0, d1) -> (d0, d1)>
]

#trait = {
  indexing_maps = #accesses,
  iterator_types = ["parallel", "parallel"],
  library_call = "some_external_fn"
}

func.func @broadcast_test(%arg0 : tensor<5xf32>, %arg1 : tensor<5xf32>, %shape : tensor<5x5xf32>) -> tensor<5x5xf32>
{
  %0 = tensor.expand_shape %arg0 [[0, 1]] : tensor<5xf32> into tensor<1x5xf32>
  %1 = tensor.expand_shape %arg1 [[0, 1]] : tensor<5xf32> into tensor<5x1xf32>
  %2 = linalg.generic #trait
     ins(%0, %1 : tensor<1x5xf32>, tensor<5x1xf32>)
    outs(%shape : tensor<5x5xf32>) {
       ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
         %3 = arith.addf %arg3, %arg4 : f32
         linalg.yield %3 : f32
       } -> tensor<5x5xf32>
  return %2 : tensor<5x5xf32>
}
//   CHECK-DAG: #[[$MAP0:.*]] = affine_map<(d0, d1) -> (d1)>
//   CHECK-DAG: #[[$MAP1:.*]] = affine_map<(d0, d1) -> (d0)>
//   CHECK-DAG: #[[$MAP2:.*]] = affine_map<(d0, d1) -> (d0, d1)>
// CHECK-LABEL: func @broadcast_test
//   CHECK-NOT:   linalg.tensor_{{.*}}shape
//       CHECK:   linalg.generic
//  CHECK-SAME:     indexing_maps = [#[[$MAP0]], #[[$MAP1]], #[[$MAP2]]]
//  CHECK-SAME:     iterator_types = ["parallel", "parallel"]
//   CHECK-NOT:   linalg.tensor_{{.*}}shape

// -----

#accesses = [
  affine_map<(d0, d1) -> (0, 0)>,
  affine_map<(d0, d1) -> (d0, d1)>
]

#trait = {
  indexing_maps = #accesses,
  iterator_types = ["parallel", "parallel"],
  library_call = "some_external_fn"
}

func.func @broadcast_scalar(%arg0 : tensor<1x1xf32>, %shape : tensor<?x?xf32>) -> tensor<?x?xf32>
{
   %0 = linalg.generic #trait
     ins(%arg0 : tensor<1x1xf32>)
    outs(%shape : tensor<?x?xf32>) {
      ^bb0(%arg2 : f32, %arg3 : f32):
        linalg.yield %arg2 : f32
   } -> tensor<?x?xf32>
   return %0 : tensor<?x?xf32>
}
//   CHECK-DAG: #[[$MAP0:.*]] = affine_map<(d0, d1) -> ()>
//   CHECK-DAG: #[[$MAP1:.*]] = affine_map<(d0, d1) -> (d0, d1)>
// CHECK-LABEL: func @broadcast_scalar
//  CHECK-SAME:   %[[ARG0:.*]]: tensor<1x1xf32>
//       CHECK:   %[[A:.*]] = tensor.collapse_shape %[[ARG0]] []
//  CHECK-SAME:     tensor<1x1xf32> into tensor<f32>
//       CHECK:   linalg.generic
//  CHECK-SAME:     indexing_maps = [#[[$MAP0]], #[[$MAP1]]]
//  CHECK-SAME:     iterator_types = ["parallel", "parallel"]
//  CHECK-SAME:     %[[A]]

// -----

#map0 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2)>
func.func @fold_unit_dim_tensor_reshape_op(%arg0 : tensor<5xf32>) -> tensor<2x5xf32>
{
  %1 = tensor.empty() : tensor<1x2x5xf32>
  %2 = linalg.generic {i64, indexing_maps = [#map1, #map0],
    iterator_types = ["parallel", "parallel", "parallel"]}
    ins(%arg0 : tensor<5xf32>) outs(%1 : tensor<1x2x5xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    } -> tensor<1x2x5xf32>
  %3 = tensor.collapse_shape %2 [[0, 1], [2]]
    : tensor<1x2x5xf32> into tensor<2x5xf32>
  return %3 : tensor<2x5xf32>
}
// CHECK-LABEL: func @fold_unit_dim_tensor_reshape_op
//       CHECK:   %[[RESULT:.+]] = linalg.generic
//       CHECK:   return %[[RESULT]]

// -----

func.func @fold_unit_dim_for_empty_tensor(%input: tensor<1x1000xf32>) -> tensor<1xf32> {
  %cst = arith.constant 0.0 : f32
  %init = tensor.empty() : tensor<1xf32>
  %fill = linalg.fill ins(%cst : f32) outs(%init : tensor<1xf32>) -> tensor<1xf32>
  %add = linalg.generic {
      indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0)>],
      iterator_types = ["parallel", "reduction"]}
    ins(%input : tensor<1x1000xf32>)outs(%fill : tensor<1xf32>) {
  ^bb0(%arg1: f32, %arg2: f32):
    %1823 = arith.addf %arg1, %arg2 : f32
    linalg.yield %1823 : f32
  } -> tensor<1xf32>
  return %add : tensor<1xf32>
}


//   CHECK-DAG: #[[MAP1:.+]] = affine_map<(d0) -> (d0)>
//   CHECK-DAG: #[[MAP2:.+]] = affine_map<(d0) -> ()>

//       CHECK: func @fold_unit_dim_for_empty_tensor


//       CHECK: %[[INPUT_RESHAPE:.+]] = tensor.collapse_shape %{{.+}} {{\[}}[0, 1]] : tensor<1x1000xf32> into tensor<1000xf32>
//       CHECK: %[[INIT:.+]] = tensor.empty() : tensor<f32>
//       CHECK: %[[FILL:.+]] = linalg.fill ins(%cst : f32) outs(%[[INIT]] : tensor<f32>) -> tensor<f32>
//       CHECK: %[[GENERIC:.+]] = linalg.generic
//  CHECK-SAME:     indexing_maps = [#[[MAP1]], #[[MAP2]]]
//  CHECK-SAME:     iterator_types = ["reduction"]
//  CHECK-SAME:   ins(%[[INPUT_RESHAPE]] : tensor<1000xf32>)
//  CHECK-SAME:   outs(%[[FILL]] : tensor<f32>)
//       CHECK: %[[GENERIC_RESHAPE:.+]] = tensor.expand_shape %[[GENERIC]] [] : tensor<f32> into tensor<1xf32>
//       CHECK: return %[[GENERIC_RESHAPE:.+]] : tensor<1xf32>


// -----

func.func @fold_slice(
    %arg0 : tensor<1x?x?x1x?x1x1xf32>, %arg1 : tensor<1x?x?x?x?x1x1xf32>,
    %arg2 : index, %arg3 : index, %arg4 : index, %arg5 : index,
    %arg6 : index, %arg7 : index) -> (tensor<1x?x?x1x?x1x1xf32>, tensor<1x?x?x1x?x1x1xf32>) {
  %0 = tensor.extract_slice %arg0[0, %arg2, %arg3, 0, %arg4, 0, 0]
                             [1, %arg5, %arg6, 1, %arg7, 1, 1] [1, 1, 1, 1, 1, 1, 1] :
      tensor<1x?x?x1x?x1x1xf32> to tensor<1x?x?x1x?x1x1xf32>
  %1 = tensor.extract_slice %arg1[%arg2, 0, %arg3, 0, 0, %arg4, 0]
                             [1, %arg5, %arg6, 1, %arg7, 1, 1] [1, 1, 1, 1, 1, 1, 1] :
      tensor<1x?x?x?x?x1x1xf32> to tensor<1x?x?x1x?x1x1xf32>
  return %0, %1 : tensor<1x?x?x1x?x1x1xf32>, tensor<1x?x?x1x?x1x1xf32>
}
//      CHECK: func @fold_slice
// CHECK-SAME:   %[[ARG0:.+]]: tensor<1x?x?x1x?x1x1xf32>
// CHECK-SAME:   %[[ARG1:.+]]: tensor<1x?x?x?x?x1x1xf32>
//      CHECK:   %[[SLICE1:.+]] = tensor.extract_slice %[[ARG0]]
// CHECK-SAME:       to tensor<?x?x?xf32>
//      CHECK:   %[[RESULT1:.+]] = tensor.expand_shape %[[SLICE1]]
// CHECK-SAME:       [0, 1], [2], [3, 4, 5, 6]
//      CHECK:   %[[SLICE2:.+]] = tensor.extract_slice %[[ARG1]]
// CHECK-SAME:       to tensor<?x?x?xf32>
//      CHECK:   %[[RESULT2:.+]] = tensor.expand_shape %[[SLICE2]]
// CHECK-SAME:       [0, 1], [2], [3, 4, 5, 6]
//      CHECK:   return %[[RESULT1]], %[[RESULT2]]

// -----

func.func @unit_dim_for_reduction(%arg0: tensor<1x?x1x?xf32>) -> tensor<1x?xf32> {
  %cst = arith.constant 1.000000e+00 : f32
  %c3 = arith.constant 3 : index
  %0 = tensor.dim %arg0, %c3 : tensor<1x?x1x?xf32>
  %1 = tensor.empty(%0) : tensor<1x?xf32>
  %2 = linalg.fill ins(%cst : f32) outs(%1 : tensor<1x?xf32>) -> tensor<1x?xf32>
  %3 = linalg.generic {
    indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>,
                     affine_map<(d0, d1, d2, d3) -> (d0, d1)>],
    iterator_types = ["parallel", "parallel", "reduction", "reduction"]}
    ins(%arg0 : tensor<1x?x1x?xf32>)
    outs(%2 : tensor<1x?xf32>) {
  ^bb0(%arg1: f32, %arg2: f32):
    %4 = arith.addf %arg1, %arg2 : f32
    linalg.yield %4 : f32
  } -> tensor<1x?xf32>
  return %3 : tensor<1x?xf32>
}
//  CHECK-DAG: #[[MAP2:.+]] = affine_map<(d0, d1) -> (d0, d1)>
//  CHECK-DAG: #[[MAP3:.+]] = affine_map<(d0, d1) -> (d0)>
//      CHECK: func @unit_dim_for_reduction
// CHECK-SAME:   %[[ARG0:.+]]: tensor<1x?x1x?xf32>
//  CHECK-DAG:   %[[RESHAPE:.+]] = tensor.collapse_shape %[[ARG0]] {{\[}}[0, 1, 2], [3]]
//      CHECK:   %[[INIT:.+]] = tensor.empty(%{{.+}}) : tensor<?xf32>
//      CHECK:   %[[FILL:.+]] = linalg.fill ins(%{{.+}}{{.*}}outs(%[[INIT]]
//      CHECK:   %[[RESULT:.+]] = linalg.generic
// CHECK-SAME:     indexing_maps = [#[[MAP2]], #[[MAP3]]]
// CHECK-SAME:     iterator_types = ["parallel", "reduction"]
// CHECK-SAME:     ins(%[[RESHAPE]] : tensor<?x?xf32>)
// CHECK-SAME:     outs(%[[FILL]] : tensor<?xf32>)
//      CHECK:   %[[RESULT_RESHAPE:.+]] = tensor.expand_shape %[[RESULT]] {{\[}}[0, 1]]
//      CHECK:   return %[[RESULT_RESHAPE]]

// -----

func.func @unit_dim_for_both_reduction(%arg0: tensor<1x?x1x1xf32>) -> tensor<1x1xf32> {
  %cst = arith.constant 1.000000e+00 : f32
  %c3 = arith.constant 3 : index
  %1 = tensor.empty() : tensor<1x1xf32>
  %2 = linalg.fill ins(%cst : f32) outs(%1 : tensor<1x1xf32>) -> tensor<1x1xf32>
  %3 = linalg.generic {
    indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>,
                     affine_map<(d0, d1, d2, d3) -> (d0, d1)>],
    iterator_types = ["parallel", "parallel", "reduction", "reduction"]}
    ins(%arg0 : tensor<1x?x1x1xf32>)
    outs(%2 : tensor<1x1xf32>) {
  ^bb0(%arg1: f32, %arg2: f32):
    %4 = arith.addf %arg1, %arg2 : f32
    linalg.yield %4 : f32
  } -> tensor<1x1xf32>
  return %3 : tensor<1x1xf32>
}
//  CHECK-DAG: #[[MAP2:.+]] = affine_map<(d0) -> (d0)>
//      CHECK: func @unit_dim_for_both_reduction
// CHECK-SAME:   %[[ARG0:.+]]: tensor<1x?x1x1xf32>
//  CHECK-DAG:   %[[RESHAPE:.+]] = tensor.collapse_shape %[[ARG0]] {{\[}}[0, 1, 2, 3]
//      CHECK:   %[[INIT:.+]] = tensor.empty() : tensor<1xf32>
//      CHECK:   %[[FILL:.+]] = linalg.fill ins(%{{.+}}{{.*}}outs(%[[INIT]]
//      CHECK:   %[[INIT2:.+]] = tensor.empty() : tensor<1xf32>
//      CHECK:   %[[RESULT:.+]] = linalg.generic
// CHECK-SAME:     indexing_maps = [#[[MAP2]], #[[MAP2]], #[[MAP2]]]
// CHECK-SAME:     iterator_types = ["parallel"]
// CHECK-SAME:     ins(%[[RESHAPE]], %[[FILL]] : tensor<?xf32>, tensor<1xf32>)
// CHECK-SAME:     outs(%[[INIT2]] : tensor<1xf32>)
//      CHECK:   %[[RESULT_RESHAPE:.+]] = tensor.expand_shape %[[RESULT]] {{\[}}[0, 1]]
//      CHECK:   return %[[RESULT_RESHAPE]]

// -----

func.func @unit_dim_for_reduction_inner(%arg0: tensor<?x1x?x1xf32>) -> tensor<?x1xf32> {
  %cst = arith.constant 1.000000e+00 : f32
  %c2 = arith.constant 2 : index
  %0 = tensor.dim %arg0, %c2 : tensor<?x1x?x1xf32>
  %1 = tensor.empty(%0) : tensor<?x1xf32>
  %2 = linalg.fill ins(%cst : f32) outs(%1 : tensor<?x1xf32>) -> tensor<?x1xf32>
  %3 = linalg.generic {
    indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>,
                     affine_map<(d0, d1, d2, d3) -> (d0, d1)>],
    iterator_types = ["parallel", "parallel", "reduction", "reduction"]}
    ins(%arg0 : tensor<?x1x?x1xf32>)
    outs(%2 : tensor<?x1xf32>) {
  ^bb0(%arg1: f32, %arg2: f32):
    %4 = arith.addf %arg1, %arg2 : f32
    linalg.yield %4 : f32
  } -> tensor<?x1xf32>
  return %3 : tensor<?x1xf32>
}
//  CHECK-DAG: #[[MAP2:.+]] = affine_map<(d0, d1) -> (d0, d1)>
//  CHECK-DAG: #[[MAP3:.+]] = affine_map<(d0, d1) -> (d0)>
//      CHECK: func @unit_dim_for_reduction_inner
// CHECK-SAME:   %[[ARG0:.+]]: tensor<?x1x?x1xf32>
//  CHECK-DAG:   %[[RESHAPE:.+]] = tensor.collapse_shape %[[ARG0]] {{\[}}[0, 1], [2, 3]]
//      CHECK:   %[[INIT:.+]] = tensor.empty(%{{.+}}) : tensor<?xf32>
//      CHECK:   %[[FILL:.+]] = linalg.fill ins(%{{.+}}{{.*}}outs(%[[INIT]]
//      CHECK:   %[[RESULT:.+]] = linalg.generic
// CHECK-SAME:     indexing_maps = [#[[MAP2]], #[[MAP3]]]
// CHECK-SAME:     iterator_types = ["parallel", "reduction"]
// CHECK-SAME:     ins(%[[RESHAPE]] : tensor<?x?xf32>)
// CHECK-SAME:     outs(%[[FILL]] : tensor<?xf32>)
//      CHECK:   %[[RESULT_RESHAPE:.+]] = tensor.expand_shape %[[RESULT]] {{\[}}[0, 1]]
//      CHECK:   return %[[RESULT_RESHAPE]]

// -----

func.func @slice_unit_dims(%arg0: tensor<1x3xf32>) -> tensor<1x1xf32> {
  %0 = tensor.extract_slice %arg0[0, 2] [1, 1] [1, 1] : tensor<1x3xf32> to tensor<1x1xf32>
  return %0 : tensor<1x1xf32>
}
// CHECK-LABEL: func @slice_unit_dims
//       CHECK:   %[[SLICE:.+]] = tensor.extract_slice
//  CHECK-SAME:     tensor<1x3xf32> to tensor<f32>
//       CHECK:   %[[RESULT:.+]] = tensor.expand_shape %[[SLICE]] []
//       CHECK:   return %[[RESULT]]

// -----

func.func @insert_slice_unit_dims(%arg0: tensor<1x3xf32>, %arg1: tensor<1x1xf32>) -> tensor<1x3xf32> {
  %0 = tensor.insert_slice %arg1 into %arg0[0, 2] [1, 1] [1, 1] : tensor<1x1xf32> into tensor<1x3xf32>
  return %0 : tensor<1x3xf32>
}
// CHECK-LABEL: func @insert_slice_unit_dims
//       CHECK:   %[[RESHAPE:.+]] = tensor.collapse_shape %{{.+}} []
//       CHECK:   %[[RESULT:.+]] = tensor.insert_slice %[[RESHAPE]]
//  CHECK-SAME:     tensor<f32> into tensor<1x3xf32>
//       CHECK:   return %[[RESULT]]

// -----

#accesses = [
  affine_map<(i, j, k, l, m) -> (i, k, m)>,
  affine_map<(i, j, k, l, m) -> ()>,
  affine_map<(i, j, k, l, m) -> (i, k, j, l, m)>
]

#trait = {
  iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel"],
  indexing_maps = #accesses,
  library_call = "some_external_func"
}

func.func @drop_one_trip_loops(%arg0 : memref<?x1x?xf32>, %arg1 : f32, %shape: memref<?x1x?x1x?xf32>) -> memref<?x1x?x1x?xf32> {
  linalg.generic #trait
     ins(%arg0, %arg1 : memref<?x1x?xf32>, f32)
    outs(%shape : memref<?x1x?x1x?xf32>) {
       ^bb0(%arg2 : f32, %arg3 : f32, %arg4 : f32) :
         linalg.yield %arg3 : f32
       }
  return %shape : memref<?x1x?x1x?xf32>
}
//   CHECK-DAG: #[[$MAP1:.*]] = affine_map<(d0, d1, d2) -> (d0, d2)>
//   CHECK-DAG: #[[$MAP2:.*]] = affine_map<(d0, d1, d2) -> ()>
//   CHECK-DAG: #[[$MAP3:.*]] = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
// CHECK-LABEL: func @drop_one_trip_loops
//       CHECK: memref.collapse_shape %{{.*}} {{\[}}[0, 1], [2]]
//       CHECK: linalg.generic
//  CHECK-SAME:   indexing_maps = [#[[$MAP1]], #[[$MAP2]], #[[$MAP3]]]
//  CHECK-SAME:   iterator_types = ["parallel", "parallel", "parallel"]

// -----

#accesses = [
  affine_map<(i, j, k, l, m) -> (i, k, m)>,
  affine_map<(i, j, k, l, m) -> (i, k, j, l, m)>
]

#trait = {
  iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel"],
  indexing_maps = #accesses,
  library_call = "some_external_func"
}

func.func @drop_one_trip_loops_indexed
  (%arg0 : memref<?x1x?xi32>, %shape: memref<?x1x?x1x?xi32>) -> memref<?x1x?x1x?xi32>
{
  linalg.generic #trait
     ins(%arg0 : memref<?x1x?xi32>)
    outs(%shape: memref<?x1x?x1x?xi32>) {
       ^bb0(%arg6 : i32, %arg7 : i32) :
         %idx0 = linalg.index 0 : index
         %idx1 = linalg.index 1 : index
         %idx2 = linalg.index 2 : index
         %idx3 = linalg.index 3 : index
         %idx4 = linalg.index 4 : index
         %1 = arith.addi %idx0, %idx1 : index
         %2 = arith.subi %1, %idx2 : index
         %3 = arith.subi %2, %idx3 : index
         %4 = arith.addi %3, %idx4 : index
         %5 = arith.index_cast %4 : index to i32
         %6 = arith.addi %5, %arg6 : i32
         linalg.yield %6 : i32
       }
  return %shape : memref<?x1x?x1x?xi32>
}
// The subtractions disappear the access map of the output memref maps its unit
// dimensions 1 and 3 to the index dimensions 2 and 3.
// CHECK-LABEL: func @drop_one_trip_loops_indexed
//       CHECK:   linalg.generic
//       CHECK:   ^{{.+}}(
//  CHECK-SAME:     %[[ARG4:[a-zA-Z0-9]+]]: i32, %{{.*}}: i32)
//       CHECK:     %[[IDX0:.+]] = linalg.index 0 : index
//       CHECK:     %[[IDX1:.+]] = linalg.index 1 : index
//       CHECK:     %[[IDX2:.+]] = linalg.index 2 : index
//       CHECK:     %[[T3:.+]] = arith.addi %[[IDX0]], %[[IDX1]]
//       CHECK:     %[[T4:.+]] = arith.addi %[[T3]], %[[IDX2]]
//       CHECK:     %[[T5:.+]] = arith.index_cast %[[T4]] : index to i32
//       CHECK:     %[[T6:.+]] = arith.addi %[[T5]], %[[ARG4]] : i32
//       CHECK:     linalg.yield %[[T6]] : i32

// -----

#map0 = affine_map<(i, j) -> (i, j)>
#access = [#map0, #map0]
#trait = {
  iterator_types = ["parallel", "parallel"],
  indexing_maps = #access,
  library_call = "some_external_func"
}

func.func @drop_all_loops(%arg0 : memref<1x1xf32>) -> memref<1x1xf32>
{
  linalg.generic #trait
     ins(%arg0 : memref<1x1xf32>)
    outs(%arg0 : memref<1x1xf32>) {
       ^bb0(%arg1: f32, %arg2: f32) :
         linalg.yield %arg1 : f32
       }
  return %arg0 : memref<1x1xf32>
}
//       CHECK: #[[$MAP0:.*]] = affine_map<() -> ()>
// CHECK-LABEL: func @drop_all_loops
//       CHECK:   memref.collapse_shape %{{.*}} []
//       CHECK:   linalg.generic
//  CHECK-SAME:     indexing_maps = [#[[$MAP0]], #[[$MAP0]]]
//  CHECK-SAME:     iterator_types = []

// -----

#map0 = affine_map<(i, j) -> (i, j)>
#access = [#map0, #map0]
#trait = {
  iterator_types = ["parallel", "parallel"],
  indexing_maps = #access,
  library_call = "some_external_func"
}

func.func @drop_all_loops_indexed
  (%arg0 : memref<1x1xi32>) -> memref<1x1xi32>{
  linalg.generic #trait
     ins(%arg0 : memref<1x1xi32>)
    outs(%arg0 : memref<1x1xi32>) {
       ^bb0(%arg3: i32, %arg4: i32) :
         %idx0 = linalg.index 0 : index
         %idx1 = linalg.index 1 : index
         %1 = arith.addi %idx0, %idx1 : index
         %2 = arith.index_cast %1 : index to i32
         %3 = arith.addi %2, %arg3 : i32
         linalg.yield %3 : i32
       }
  return %arg0 : memref<1x1xi32>
}

// CHECK-LABEL: func @drop_all_loops_indexed
//       CHECK:   linalg.generic
//       CHECK:   ^{{.+}}(%[[ARG1:.+]]: i32, %[[ARG2:.+]]: i32)
//       CHECK:     linalg.yield %[[ARG1]] : i32

// -----

#accesses = [
  affine_map<(d0) -> (0, d0)>,
  affine_map<(d0) -> (d0)>
]

#trait = {
  indexing_maps = #accesses,
  iterator_types = ["parallel"],
  library_call = "some_external_fn"
}

func.func @leading_dim_1_canonicalization(%arg0: memref<1x5xf32>, %shape: memref<5xf32>) -> memref<5xf32> {
  linalg.generic #trait
     ins(%arg0 : memref<1x5xf32>)
    outs(%shape : memref<5xf32>) {
  ^bb0(%arg2: f32, %arg3: f32):
    linalg.yield %arg2 : f32
  }
  return %shape : memref<5xf32>
}
//   CHECK: #[[$MAP1:.*]] = affine_map<(d0) -> (d0)>

// CHECK-LABEL: func @leading_dim_1_canonicalization
//       CHECK:   memref.collapse_shape %{{.*}} {{\[}}[0, 1]]
//       CHECK:   linalg.generic
//  CHECK-SAME:     indexing_maps = [#[[$MAP1]], #[[$MAP1]]]
//  CHECK-SAME:     iterator_types = ["parallel"]

// -----

#accesses = [
  affine_map<(d0, d1) -> (0, d1)>,
  affine_map<(d0, d1) -> (d0, 0)>,
  affine_map<(d0, d1) -> (d0, d1)>
]

#trait = {
  indexing_maps = #accesses,
  iterator_types = ["parallel", "parallel"],
  library_call = "some_external_fn"
}

func.func @broadcast_test(%arg0 : memref<5xf32>, %arg1 : memref<5xf32>, %shape : memref<5x5xf32>) -> memref<5x5xf32>
{
  %0 = memref.expand_shape %arg0 [[0, 1]] : memref<5xf32> into memref<1x5xf32>
  %1 = memref.expand_shape %arg1 [[0, 1]] : memref<5xf32> into memref<5x1xf32>
  linalg.generic #trait
     ins(%0, %1 : memref<1x5xf32>, memref<5x1xf32>)
    outs(%shape : memref<5x5xf32>) {
       ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
         %3 = arith.addf %arg3, %arg4 : f32
         linalg.yield %3 : f32
       }
  return %shape : memref<5x5xf32>
}
//   CHECK-DAG: #[[$MAP0:.*]] = affine_map<(d0, d1) -> (d1)>
//   CHECK-DAG: #[[$MAP1:.*]] = affine_map<(d0, d1) -> (d0)>
//   CHECK-DAG: #[[$MAP2:.*]] = affine_map<(d0, d1) -> (d0, d1)>
// CHECK-LABEL: func @broadcast_test
//   CHECK-NOT:   linalg.memref_{{.*}}shape
//       CHECK:   linalg.generic
//  CHECK-SAME:     indexing_maps = [#[[$MAP0]], #[[$MAP1]], #[[$MAP2]]]
//  CHECK-SAME:     iterator_types = ["parallel", "parallel"]
//   CHECK-NOT:   linalg.memref_{{.*}}shape

// -----

#accesses = [
  affine_map<(d0, d1) -> (0, 0)>,
  affine_map<(d0, d1) -> (d0, d1)>
]

#trait = {
  indexing_maps = #accesses,
  iterator_types = ["parallel", "parallel"],
  library_call = "some_external_fn"
}

func.func @broadcast_scalar(%arg0 : memref<1x1xf32>, %shape : memref<?x?xf32>) -> memref<?x?xf32>
{
   linalg.generic #trait
     ins(%arg0 : memref<1x1xf32>)
    outs(%shape : memref<?x?xf32>) {
      ^bb0(%arg2 : f32, %arg3 : f32):
        linalg.yield %arg2 : f32
   }
   return %shape : memref<?x?xf32>
}
//   CHECK-DAG: #[[$MAP0:.*]] = affine_map<(d0, d1) -> ()>
//   CHECK-DAG: #[[$MAP1:.*]] = affine_map<(d0, d1) -> (d0, d1)>
// CHECK-LABEL: func @broadcast_scalar
//  CHECK-SAME:   %[[ARG0:.*]]: memref<1x1xf32>
//       CHECK:   %[[A:.*]] = memref.collapse_shape %[[ARG0]] []
//  CHECK-SAME:     memref<1x1xf32> into memref<f32>
//       CHECK:   linalg.generic
//  CHECK-SAME:     indexing_maps = [#[[$MAP0]], #[[$MAP1]]]
//  CHECK-SAME:     iterator_types = ["parallel", "parallel"]
//  CHECK-SAME:     %[[A]]

// -----

#map0 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2)>
func.func @fold_unit_dim_memref_reshape_op(%arg0 : memref<5xf32>) -> memref<2x5xf32>
{
  %1 = memref.alloc() : memref<1x2x5xf32>
  linalg.generic {i64, indexing_maps = [#map1, #map0],
    iterator_types = ["parallel", "parallel", "parallel"]}
    ins(%arg0 : memref<5xf32>) outs(%1 : memref<1x2x5xf32>) {
    ^bb0(%arg1: f32, %arg2: f32):
      linalg.yield %arg1 : f32
    }
  %3 = memref.collapse_shape %1 [[0, 1], [2]]
    : memref<1x2x5xf32> into memref<2x5xf32>
  return %3 : memref<2x5xf32>
}
// CHECK-LABEL: func @fold_unit_dim_memref_reshape_op
//       CHECK:   %[[ALLOC:.*]] = memref.alloc() : memref<1x2x5xf32>
//       CHECK:   %[[OUT:.*]] = memref.collapse_shape %[[ALLOC]]
//       CHECK:   linalg.generic
//       CHECK-SAME:   outs(%[[OUT:.*]] :
//       CHECK:   %[[RESULT:.*]] = memref.collapse_shape %[[ALLOC]]
//       CHECK:   return %[[RESULT]]

// -----

func.func @fold_unit_dim_for_init_memref(%input: memref<1x1000xf32>) -> memref<1xf32> {
  %cst = arith.constant 0.0 : f32
  %init = memref.alloc() : memref<1xf32>
  linalg.generic {
      indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0)>],
      iterator_types = ["parallel", "reduction"]}
    ins(%input : memref<1x1000xf32>)outs(%init : memref<1xf32>) {
  ^bb0(%arg1: f32, %arg2: f32):
    %1823 = arith.addf %arg1, %arg2 : f32
    linalg.yield %1823 : f32
  }
  return %init : memref<1xf32>
}


//   CHECK-DAG: #[[MAP1:.+]] = affine_map<(d0) -> (d0)>
//   CHECK-DAG: #[[MAP2:.+]] = affine_map<(d0) -> ()>

//       CHECK: func @fold_unit_dim_for_init_memref
//       CHECK: %[[INIT:.+]] = memref.alloc() : memref<1xf32>
//       CHECK: %[[INPUT_RESHAPE:.+]] = memref.collapse_shape %{{.+}} {{\[}}[0, 1]] : memref<1x1000xf32> into memref<1000xf32>
//       CHECK: %[[INIT_RESHAPE:.+]] = memref.collapse_shape %[[INIT]] [] : memref<1xf32> into memref<f32>
//       CHECK: linalg.generic
//  CHECK-SAME:     indexing_maps = [#[[MAP1]], #[[MAP2]]]
//  CHECK-SAME:     iterator_types = ["reduction"]
//  CHECK-SAME:   ins(%[[INPUT_RESHAPE]] : memref<1000xf32>)
//  CHECK-SAME:   outs(%[[INIT_RESHAPE]] : memref<f32>)
//       CHECK: return %[[INIT:.+]] : memref<1xf32>


// -----
// Test that nothing changes and no assertions are fired for memrefs with affine
// maps while still changing the other operations.

#accesses = [
  affine_map<(i, j, k, l, m) -> (i, k, m)>,
  affine_map<(i, j, k, l, m) -> ()>,
  affine_map<(i, j, k, l, m) -> (i, k, j, l, m)>
]

#trait = {
  iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel"],
  indexing_maps = #accesses,
  library_call = "some_external_func"
}

func.func @input_stays_same(%arg0 : memref<?x1x?xf32, strided<[?, 1, 1]>>, %arg1 : f32, %shape: memref<?x1x?x1x?xf32>) -> memref<?x1x?x1x?xf32> {
  linalg.generic #trait
     ins(%arg0, %arg1 : memref<?x1x?xf32, strided<[?, 1, 1]>>, f32)
    outs(%shape : memref<?x1x?x1x?xf32>) {
       ^bb0(%arg2 : f32, %arg3 : f32, %arg4 : f32) :
         linalg.yield %arg3 : f32
       }
  return %shape : memref<?x1x?x1x?xf32>
}

// CHECK-DAG:     #[[MAP1:.*]] = affine_map<(d0, d1, d2) -> (d0, 0, d2)>
// CHECK-DAG:     #[[MAP2:.*]] = affine_map<(d0, d1, d2) -> ()>
// CHECK-DAG:     #[[MAP3:.*]] = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
// CHECK:     func @input_stays_same(
// CHECK-SAME:  %[[ARG0:.*]]: memref<?x1x?xf32, strided<[?, 1, 1]>>,
// CHECK-SAME:  %[[ARG1:.*]]: f32, %[[ARG2:.*]]: memref<?x1x?x1x?xf32>)
// CHECK-SAME   -> memref<?x1x?x1x?xf32> {
// CHECK:      %[[OUT:.*]] = memref.collapse_shape %[[ARG2]] {{\[}}[0, 1], [2, 3], [4]]
// CHECK-SAME:   : memref<?x1x?x1x?xf32> into memref<?x?x?xf32>
// CHECK:      linalg.generic
// CHECK-SAME:   {indexing_maps = [#[[MAP1]], #[[MAP2]], #[[MAP3]]],
// CHECK-SAME:   iterator_types = ["parallel", "parallel", "parallel"]}
// CHECK-SAME:   ins(%[[ARG0]], %[[ARG1]] : memref<?x1x?xf32, strided<[?, 1, 1]>>, f32)
// CHECK-SAME:   outs(%[[OUT]] : memref<?x?x?xf32>) {
// CHECK:      ^bb0(%{{.*}}: f32, %[[ARG:.*]]: f32, %{{.*}}: f32):
// CHECK:       linalg.yield %[[ARG]] : f32
// CHECK:      }
// CHECK:      return %[[ARG2]] : memref<?x1x?x1x?xf32>

// -----

// Negative test for case with tensor encoding.
#matvec = {
  indexing_maps = [
    affine_map<(i,j) -> (i,j)>, // A
    affine_map<(i,j) -> (j)>,   // b
    affine_map<(i,j) -> (i)>    // x (out)
  ],
  iterator_types = ["parallel", "reduction"]
}

#CSR = #sparse_tensor.encoding<{ dimLevelType = ["dense", "compressed"] }>

func.func @sparse_case(%arg0: tensor<8x8xf32, #CSR>, %arg1: tensor<8xf32>) -> tensor<8xf32> {
    %0 = tensor.empty() : tensor<8xf32>
    %1 = linalg.generic #matvec
      ins(%arg0, %arg1: tensor<8x8xf32, #CSR>, tensor<8xf32>)
      outs(%0: tensor<8xf32>) {
      ^bb(%a: f32, %b: f32, %x: f32):
        %m = arith.mulf %a, %b : f32
        %add = arith.addf %x, %m : f32
        linalg.yield %add : f32
    } -> tensor<8xf32>
    return %1: tensor<8xf32>
}

// CHECK-LABEL: func @sparse_case
//  CHECK-NEXT:   tensor.empty
//  CHECK-NEXT:   linalg.generic

// -----

func.func @reduce_dispatch_0() -> tensor<4x2xf32> {
  %c2 = arith.constant 2 : index
  %c4 = arith.constant 4 : index
  %cst = arith.constant 0.000000e+00 : f32
  %0 = tensor.empty() : tensor<4x2xf32>
  %res = scf.foreach_thread (%arg0, %arg1) in (%c4, %c2) shared_outs(%o = %0) -> (tensor<4x2xf32>) {
    %1 = tensor.empty() : tensor<1x1xf32>
    %2 = linalg.fill ins(%cst : f32) outs(%1 : tensor<1x1xf32>) -> tensor<1x1xf32>
    scf.foreach_thread.perform_concurrently {
      //      CHECK: tensor.parallel_insert_slice %{{[0-9a-z]*}} into %{{[0-9a-z]*}}
      // CHECK-SAME: [%{{.*}}, %{{.*}}] [1, 1] [1, 1] : tensor<f32> into tensor<4x2xf32>
      tensor.parallel_insert_slice %2 into %o[%arg0, %arg1] [1, 1] [1, 1] :
        tensor<1x1xf32> into tensor<4x2xf32>
    }
  }
  return %res: tensor<4x2xf32>
}

// -----

#map0 = affine_map<(i, j) -> (i, j)>
#access = [#map0, #map0]
#trait = {
  iterator_types = ["parallel", "parallel"],
  indexing_maps = #access,
  library_call = "some_external_func"
}

func.func @drop_all_loops(%arg0 : memref<1x1xf32, 3>) -> memref<1x1xf32, 3>
{
  linalg.generic #trait
     ins(%arg0 : memref<1x1xf32, 3>)
    outs(%arg0 : memref<1x1xf32, 3>) {
       ^bb0(%arg1: f32, %arg2: f32) :
         linalg.yield %arg1 : f32
       }
  return %arg0 : memref<1x1xf32, 3>
}

// CHECK-LABEL: func @drop_all_loops
//       CHECK:   memref.collapse_shape 
//  CHECK-SAME:     [] : memref<1x1xf32, 3> into memref<f32, 3>
//       CHECK:   linalg.generic{{.*}}memref<f32, 3>
