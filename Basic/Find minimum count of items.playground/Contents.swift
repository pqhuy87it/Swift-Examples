import UIKit

var str = "Hello, playground"

typealias SolutionHasNotExceededTarget = (Int, Int) -> Bool

struct ArrayWithSum: Comparable {

	static let empty = ArrayWithSum([])
	let array: [Int]
	let sum: Int

	init(_ array: [Int]) {
		self.array = array
		self.sum = array.reduce(0, +)
	}

	private init(arrayWithSum: ArrayWithSum, elm: Int) {
		self.array = arrayWithSum.array + [elm]
		self.sum = arrayWithSum.sum + elm
	}

	func appending(elm: Int) -> ArrayWithSum {
		return ArrayWithSum(arrayWithSum: self, elm: elm)
	}

	static func < (lhs: ArrayWithSum, rhs: ArrayWithSum) -> Bool {
		lhs.array.count < rhs.array.count
	}
}

func visit(solution: ArrayWithSum,
		   unusedElms: [Int],
		   target: Int,
		   solutionHasNotExceededTarget: SolutionHasNotExceededTarget) -> ArrayWithSum? {

	if solution.sum == target {
		return solution
	}

	guard solutionHasNotExceededTarget(solution.sum, target) else {
		return nil
	}


	return unusedElms
		.enumerated()
		.map { (offset, elm) in
			var unusedElms = unusedElms
			unusedElms.remove(at: offset)
			return visit(solution: solution.appending(elm: elm),
						 unusedElms: unusedElms,
						 target: target,
						 solutionHasNotExceededTarget: solutionHasNotExceededTarget)
	}
	.compactMap { $0 }
	.min()
}

func smallestSubset(of nums: [Int], whereSumIs target: Int) -> [Int]? {

	let sorting: SolutionHasNotExceededTarget = target > 0
		? { $0 < $1 }
		: { $0 > $1 }

	let sortedNums = nums.sorted(by: sorting)

	return visit(solution: .empty,
				 unusedElms: sortedNums,
				 target: target,
				 solutionHasNotExceededTarget: sorting)?.array
}

smallestSubset(of: [1, 9, 2, 5, 3, 10], whereSumIs: 13)

smallestSubset(of: [1, 1, 1, 1, 5, -1], whereSumIs: 4)

smallestSubset(of: [-1, 2, 10, 1, -1, -3, 5, -15], whereSumIs: -5)

smallestSubset(of: [-50, 2, 10, 1, -1, -3, 5, -5], whereSumIs: -5)

smallestSubset(of: [10, 9, 9, 2], whereSumIs: 20)
